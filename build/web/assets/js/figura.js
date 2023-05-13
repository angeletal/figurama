/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

 function cambiarImagen(url) {
        var imagenPrincipal = document.getElementById('main-image');
        imagenPrincipal.src = 'assets/images/figuras/' + url;
    }

        function zoom(event) {
            const zoomContainer = event.currentTarget;
            const image = zoomContainer.querySelector('img');

            // Obtener la posición del ratón dentro del contenedor de zoom
            const { left, top, width, height } = zoomContainer.getBoundingClientRect();
            const x = (event.clientX - left) / width;
            const y = (event.clientY - top) / height;

            // Aplicar el efecto de zoom a la imagen
            image.style.transformOrigin = `${x * 100}% ${y * 100}%`;
            image.style.transform = 'scale(2)';
        }

        function resetZoom(event) {
            const zoomContainer = event.currentTarget;
            const image = zoomContainer.querySelector('img');

            // Restablecer el tamaño original de la imagen
            image.style.transformOrigin = 'initial';
            image.style.transform = 'initial';
        }
