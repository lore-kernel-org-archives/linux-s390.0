Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbgLIGzJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 01:55:09 -0500
Subject: Re: [PATCH 1/1] crypto: Fix possible buffer overflows in
 pkey_protkey_aes_attr_read
References: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <04b376ce-bb1c-f7ff-a41a-8905badd9dba@de.ibm.com>
Date: Wed, 9 Dec 2020 07:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Xiaohui Zhang <ruc_zhangxiaohui@163.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 09.12.20 07:47, Xiaohui Zhang wrote:
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> 
> pkey_protkey_aes_attr_read() calls memcpy() without checking the
> destination size may trigger a buffer overflower.

To me it looks like protkey.len is generated programmatically in pkey_genprotkey/pkey_clr2protkey
and this purely depends on the keytype and we do check for known ones.
Not sure how this can happen.

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
> 
