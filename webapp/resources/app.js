(function(){
    const form = document.getElementById('pointForm');
    const submitBtn = document.getElementById('submitBtn');
    const yInput = document.getElementById('y');
    const canvasXInput = document.getElementById('canvasX');
    const canvasYInput = document.getElementById('canvasY');

    const xErr = document.getElementById('xErr');
    const yErr = document.getElementById('yErr');
    const rErr = document.getElementById('rErr');
    const respErr = document.getElementById('respErr');

    const canvas = document.getElementById('areaCanvas');
    const ctx = canvas.getContext('2d');
    const canvasSize = 400;
    const center = canvasSize / 2;
    const scale = 40;

    let clickedPoint = null;

    function getChecked(name){ const n=document.getElementsByName(name); for(let i=0;i<n.length;i++){ if(n[i].checked) return n[i].value; } return null; }
    function clearErrors(){ xErr.textContent=''; yErr.textContent=''; rErr.textContent=''; respErr.textContent=''; }

    function validate(source){
        clearErrors();
        let ok = true;
        let xValue, yValue, rValue;
        if (source === 'form') {
            xValue = getChecked('x');
            rValue = getChecked('r');
            yValue = (yInput.value || '').trim().replace(',', '.');
        } else if (source === 'canvas' && clickedPoint) {
            xValue = clickedPoint.x;
            yValue = clickedPoint.y;
            rValue = getChecked('r');
        } else {
            return false;
        }
         if (xValue === '' || xValue === null || typeof xValue === 'undefined') {
                xErr.textContent = 'Выберите X';
                ok = false;
            } else {
                const xNum = Number(xValue);
                if (Number.isNaN(xNum)) {
                xErr.textContent = 'X должен быть числом';
                ok = false;
                }
            }

            // R
            if (rValue === '' || rValue === null || typeof rValue === 'undefined') {
                rErr.textContent = 'Выберите R';
                ok = false;
            } else {
                const rNum = Number(rValue);
                if (Number.isNaN(rNum)) {
                rErr.textContent = 'R должен быть числом';
                ok = false;
                }
            }

            // Y
            if (yValue === '' || yValue === null || typeof yValue === 'undefined') {
                yErr.textContent = 'Введите Y';
                ok = false;
            } else {
            const yNum = Number(yValue);
            if (!Number.isFinite(yNum)) {
                yErr.textContent = 'Y должен быть числом';
                ok = false;
                } else if (yNum < -5 || yNum > 3) {
                yErr.textContent = 'Y в диапазоне [-5, 3]';
                ok = false;
                }
                if (typeof yValue === 'string' && yValue.length > 10) {
                yErr.textContent = 'Y не более 10 символов';
                ok = false;
                }
            }

        return ok;
    }

    function drawAxes(currentR){
        ctx.clearRect(0, 0, canvasSize, canvasSize);
        ctx.save();
        ctx.translate(center, center);
        ctx.strokeStyle = '#888';
        ctx.lineWidth = 1;
        ctx.font = '12px Arial';
        ctx.fillStyle = '#333';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.beginPath(); ctx.moveTo(-center, 0); ctx.lineTo(center, 0); ctx.stroke();
        ctx.beginPath(); ctx.moveTo(0, -center); ctx.lineTo(0, center); ctx.stroke();
        for (let i=-4;i<=4;i++){ if(i===0) continue; ctx.beginPath(); ctx.moveTo(i*scale,-3); ctx.lineTo(i*scale,3); ctx.stroke(); ctx.fillText(i, i*scale, 15); }
        if (currentR != null){ ctx.fillText('R', currentR*scale, -10); ctx.fillText('-R', -currentR*scale, -10); }
        for (let i=-5;i<=3;i++){ if(i===0) continue; ctx.beginPath(); ctx.moveTo(-3,-i*scale); ctx.lineTo(3,-i*scale); ctx.stroke(); ctx.fillText(i, -15, -i*scale); }
        if (currentR != null){ ctx.fillText('R', 15, -currentR*scale); ctx.fillText('R/2', 15, -(currentR/2)*scale); ctx.fillText('-R', 15, currentR*scale); ctx.fillText('-R/2', 15, (currentR/2)*scale); }
        ctx.restore();
    }

    function drawRegion(currentR){
        drawAxes(currentR);
        if (currentR == null) return;
        ctx.save();
        ctx.translate(center, center);
        ctx.fillStyle='rgba(102,126,234,0.4)'; ctx.strokeStyle='#667eea'; ctx.lineWidth=1;
        ctx.beginPath(); ctx.moveTo(0,0); ctx.lineTo(currentR*scale,0); ctx.lineTo(0,-(currentR/2)*scale); ctx.closePath(); ctx.fill(); ctx.stroke();
        ctx.beginPath(); ctx.rect(-currentR*scale, -currentR/2*scale, currentR*scale, currentR/2*scale); ctx.closePath(); ctx.fill(); ctx.stroke();
        ctx.beginPath(); ctx.moveTo(0,0); ctx.arc(0,0,currentR*scale, Math.PI/2, Math.PI); ctx.closePath(); ctx.fill(); ctx.stroke();
        ctx.restore();
    }

    function drawPoint(x,y,color,radius=4){
        ctx.save(); ctx.translate(center,center);
        const px=x*scale, py=-y*scale;
        ctx.beginPath(); ctx.arc(px,py,radius,0,Math.PI*2); ctx.fillStyle=color; ctx.fill(); ctx.strokeStyle='#000'; ctx.lineWidth=1; ctx.stroke(); ctx.restore();
    }

    function redrawAll(){
        const currentR = parseFloat(getChecked('r'));
        drawRegion(currentR);
        const historyElement = document.getElementById('resultsBody');
        if (historyElement){
            const rows = historyElement.querySelectorAll('tr');
            rows.forEach(tr => {
                const tds = tr.querySelectorAll('td');
                if (tds.length === 6){
                    const x=parseFloat(tds[0].textContent);
                    const y=parseFloat(tds[1].textContent);
                    const isHit=tds[3].textContent.trim()==='Да';
                    drawPoint(x,y, isHit? '#27ae60':'#e74c3c');
                }
            });
        }
        const resultData = document.getElementById('resultData');
        if (resultData){
            const rx = parseFloat(resultData.dataset.x);
            const ry = parseFloat(resultData.dataset.y);
            const rhit = (resultData.dataset.hit === 'true');
            drawPoint(rx, ry, rhit? '#27ae60':'#e74c3c');
        }
        if (clickedPoint){ drawPoint(clickedPoint.x, clickedPoint.y, 'blue'); }
    }

    canvas.addEventListener('click', function(e){
        const currentR = parseFloat(getChecked('r'));
        if (!currentR){ respErr.textContent='О невозможности определения координат точки'; return; }
        respErr.textContent='';
        const rect = canvas.getBoundingClientRect();
        const xPx = e.clientX - rect.left; const yPx = e.clientY - rect.top;
        const x = (xPx - center)/scale; const y = (center - yPx)/scale;
        const xLimited = Math.min(Math.max(x, -4), 4);
        const yLimited = Math.min(Math.max(y, -5), 3);
        clickedPoint = { x: xLimited, y: yLimited };
        canvasXInput.value = xLimited.toFixed(2);
        canvasYInput.value = yLimited.toFixed(2);
        let closestXRadio=null, minDiffX=Infinity;
        document.querySelectorAll('input[name="x"]').forEach(radio=>{
            const val=parseFloat(radio.value), diff=Math.abs(val - xLimited);
            if (diff < minDiffX){ minDiffX = diff; closestXRadio = radio; }
        });
        if (closestXRadio) closestXRadio.checked = true;
        yInput.value = yLimited.toFixed(2);
        redrawAll();
    });

    function submitForm(){
        if (!validate('form')) return;
        form.submit();
    }

    document.querySelectorAll('input[name="r"]').forEach(input=>{ input.addEventListener('change', redrawAll); });

    const initialRInput = document.getElementById('initialR');
    if (initialRInput){
        const initialR = parseFloat(initialRInput.value);
        if (!isNaN(initialR)){
            document.querySelectorAll('input[name="r"]').forEach(radio=>{ if(parseFloat(radio.value)===initialR){ radio.checked=true; }});
        }
    }
    const paramY = document.getElementById('paramY');
    if (paramY){ yInput.value = String(paramY.value).replace('.', ','); }

    if (submitBtn){ submitBtn.addEventListener('click', submitForm); }

    redrawAll();
})();


