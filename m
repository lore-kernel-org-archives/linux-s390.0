Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch] netiucv: silence an underflow warning
References: <20160714113016.GJ18175@mwanda>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 15 Jul 2016 09:11:58 +0200
MIME-Version: 1.0
In-Reply-To: <20160714113016.GJ18175@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <57888CBE.9050002@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dan,

thanks for reporting this netiucv-problem. There is an implication: 
Without fix, buffer values between 2**31 and 2**32 are not detected as 
invalid values. Your fix would help, but since we have to touch the 
code, I suggest to modernize it, moving from simple_strtoul() to 
kstrtouint(). This would be the patch I have in mind:

--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -1564,21 +1564,21 @@ static ssize_t buffer_write (struct devi
  {
  	struct netiucv_priv *priv = dev_get_drvdata(dev);
  	struct net_device *ndev = priv->conn->netdev;
-	char         *e;
-	int          bs1;
+	unsigned int bs1;
+	int rc;

  	IUCV_DBF_TEXT(trace, 3, __func__);
  	if (count >= 39)
  		return -EINVAL;

-	bs1 = simple_strtoul(buf, &e, 0);
+	rc = kstrtouint(buf, 0, &bs1);

-	if (e && (!isspace(*e))) {
-		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %02x\n",
-			*e);
+	if (rc == -EINVAL) {
+		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %s\n",
+			buf);
  		return -EINVAL;
  	}
-	if (bs1 > NETIUCV_BUFSIZE_MAX) {
+	if ((rc == -ERANGE) || (bs1 > NETIUCV_BUFSIZE_MAX)) {
  		IUCV_DBF_TEXT_(setup, 2,
  			"buffer_write: buffer size %d too large\n",
  			bs1);

And a question about your static checker detecting this problem: Is it a 
private checker, or something we could use as well?
Does your checker like my patch version?

Thanks, Ursula

On 07/14/2016 01:30 PM, Dan Carpenter wrote:
> I haven't looked at the implications but we accidentally allow bs1 to
> be negative.  It makes my static checker complain.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
> index b0e8ffd..85a5744 100644
> --- a/drivers/s390/net/netiucv.c
> +++ b/drivers/s390/net/netiucv.c
> @@ -1578,7 +1578,7 @@ static ssize_t buffer_write (struct device *dev, struct device_attribute *attr,
>   			*e);
>   		return -EINVAL;
>   	}
> -	if (bs1 > NETIUCV_BUFSIZE_MAX) {
> +	if (bs1 < 0 || bs1 > NETIUCV_BUFSIZE_MAX) {
>   		IUCV_DBF_TEXT_(setup, 2,
>   			"buffer_write: buffer size %d too large\n",
>   			bs1);
>
