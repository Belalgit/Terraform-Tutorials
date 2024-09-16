_**Static Website Hosting using Terraform and AWS S3 Bucket**_

Terraform Code:
1. **Provider Configuration**: Specifies AWS and random providers.
2. **Bucket Creation**: Creates an S3 bucket with a unique name.
3. **Public Access**: Configures public access to the bucket.
4. **Website Configuration**: Sets up the bucket for static website hosting.
5. **File Uploads**: Uploads the index.html and styles.css files to the bucket.
6. **Website Endpoint**: Outputs the URL of the static website.
7. **Amazon S3 website endpoint URL**: http://{your-bucket-name}.s3-website.{region}.amazonaws.com
