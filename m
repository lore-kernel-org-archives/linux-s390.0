Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgLIHrD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 02:47:03 -0500
Subject: Re: [PATCH 1/1] crypto: Fix possible buffer overflows in
 pkey_protkey_aes_attr_read
References: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <601cf44e-1de4-4550-2bad-8087092bd010@linux.ibm.com>
Date: Wed, 9 Dec 2020 08:46:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Xiaohui Zhang <ruc_zhangxiaohui@163.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 09.12.20 07:47, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>
> pkey_protkey_aes_attr_read() calls memcpy() without checking the
> destination size may trigger a buffer overflower.
>
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 99cb60ea6..abc237130 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -1589,6 +1589,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
>  	if (rc)
>  		return rc;
>  
> +	if (protkey.len > MAXPROTKEYSIZE)
> +		protkey.len = MAXPROTKEYSIZE;
>  	protkeytoken.len = protkey.len;
>  	memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
>  
> @@ -1599,6 +1601,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
>  		if (rc)
>  			return rc;
>  
> +		if (protkey.len > MAXPROTKEYSIZE)
> +			protkey.len = MAXPROTKEYSIZE;
>  		protkeytoken.len = protkey.len;
>  		memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
>  
Thanks Xiaohui
but one rule within the kernel is to trust the other internal functions to do the right thing.
So usually only on entrance into the kernel the api parameters are checked but within the
kernel each function trusts the other and no further parameter check is done. Otherwise
endless checks of input parameters would take place which is killing the performance.
As you can see the protkey object is stored by the function pkey_genprotkey() which is
called just 2 lines above. An internal function the module should trust here. I don't think
there is an additional length check needed here.
However, Thanks for your contribution.
Harald Freudenberger
see this function calls another function in the very same file and
