//blacklist all file attachments
// window.addEventListener('trix-file-accept', function(event) {
//     event.preventDefault();
//     alert('File attachments not supported!');
// });

//accept only image files
// window.addEventListener('trix-file-accept', function (event) {
//     const acceptedFile = ['image/png', 'image/jpeg'];
//     if (!acceptedFile.includes(event.file.type))
//       event.preventDefault();
//       alert('File attachments only supports jpeg and Png!');
// });

//max file size
// window.addEventListener('trix-file-accept', function (event) {
//     const acceptedSize = 1024 * 1024; //1MB
//     if (event.file.size > acceptedSize)
//       event.preventDefault();
//       alert('File attachments size must be <= 1MB');
// });