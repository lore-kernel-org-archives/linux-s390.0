Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725806AbgHCHSG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Aug 2020 03:18:06 -0400
Subject: Re: [PATCH] s390/pkey: Remove redundant variable initialization
References: <20200802111526.4883-1-tianjia.zhang@linux.alibaba.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <297c9d42-14ed-8972-d3f0-954a6fe9859f@linux.ibm.com>
Date: Mon, 3 Aug 2020 09:18:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200802111526.4883-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com

On 02.08.20 13:15, Tianjia Zhang wrote:
> In the first place, the initialization value of `rc` is wrong.
> It is unnecessary to initialize `rc` variables, so remove their
> initialization operation.
>
> Fixes: f2bbc96e7cfad ("s390/pkey: add CCA AES cipher key support")
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 74e63ec49068..58140506a8e7 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -818,7 +818,7 @@ static int pkey_keyblob2pkey2(const struct pkey_apqn *apqns, size_t nr_apqns,
>  static int pkey_apqns4key(const u8 *key, size_t keylen, u32 flags,
>  			  struct pkey_apqn *apqns, size_t *nr_apqns)
>  {
> -	int rc = EINVAL;
> +	int rc;
>  	u32 _nr_apqns, *_apqns = NULL;
>  	struct keytoken_header *hdr = (struct keytoken_header *)key;
>  
> @@ -886,7 +886,7 @@ static int pkey_apqns4keytype(enum pkey_key_type ktype,
>  			      u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
>  			      struct pkey_apqn *apqns, size_t *nr_apqns)
>  {
> -	int rc = -EINVAL;
> +	int rc;
>  	u32 _nr_apqns, *_apqns = NULL;
>  
>  	if (ktype == PKEY_TYPE_CCA_DATA || ktype == PKEY_TYPE_CCA_CIPHER) {
Thanks, I've picked this one and committed to the s390 subsystem.
