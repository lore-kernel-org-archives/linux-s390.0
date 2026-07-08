Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EB4A3418
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529579; cv=none; b=UquYpYF+OMgMqAx/EIhwn+c3nPLDRUhkZu5mt9V+lGSR1N1U7oGc7D2XlWU/Rdw7eA2MnlRtAesdCM5LerZ2It3Y/zWvQXd9lA4eRUQx0JvTo+saiD5VNvi7eucAlvO7QS5QQZyLyZYWdvpvyrDyU6t6Iu9rdhtKtPucimxkJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529579; c=relaxed/simple;
	bh=O5PAGmMxG/eoeQS1/yVc9AAn7Zkyh5omks4FGHqmmAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZjcsrsiAs3vKb99KTZYlgn9g5BCTrIzK3lN5lQNKSYi3DQzqzSDiSCFAFthP5p1vQclsc0o6yDGdxJP9F+pUtPEfGcXDT+FTxz9XEovUeOO5F+lg/ensDkrA/nJ+URIzc7kHmZwEuMfAYeqkGH/DQITI1QwTGGUhkDrwsxXhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jo8l97WE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jo8l97WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529567;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr24SCSavwO6J0edzXKNH3n6vlLoJ4F4B9pJaia4mh4=;
	b=Jo8l97WES9k1oIENKp7Pgbb/VHrki1pkVhMLe2C7jkuTHQjLdBrc6Vhay3ml8oaQ8EX4FO
	lfGSiNBa0OzZ+UTu4eDJG7cX54mZJQaJkJ+Bhdi6tu1elMUozGOUHP7tYs8N6v7UqkngWV
	8MxaUwHX4SsZpLOveE6OycQkTFzz+Eg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-oAUpjMjhOCaGlcPmPLBu-g-1; Wed,
 08 Jul 2026 12:52:45 -0400
X-MC-Unique: oAUpjMjhOCaGlcPmPLBu-g-1
X-Mimecast-MFC-AGG-ID: oAUpjMjhOCaGlcPmPLBu-g_1783529563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449EA19560B5;
	Wed,  8 Jul 2026 16:52:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B578D1956047;
	Wed,  8 Jul 2026 16:52:38 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:52:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
	thuth@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	linux-s390@vger.kernel.org, dengler@linux.ibm.com,
	borntraeger@linux.ibm.com, fcallies@linux.ibm.com,
	cohuck@redhat.com
Subject: Re: [PATCH v11 18/21] crypto: Add aes-helpers file to support some
 AES modes
Message-ID: <ak6AUxKNGquGyHoC@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-19-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707161815.40919-19-freude@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jul 07, 2026 at 06:18:05PM +0200, Harald Freudenberger wrote:
> Add a new file crypto/aes-helpers.c with simple functions
> to support some AES modes:
> - AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
> - AES ctr: AES_ctr_encrypt()
> - AES xts: AES_xts_encrypt() AES_xts_decrypt()
> and some AES related helpers:
> - AES_xor()
> - AES_xts_prep_next_tweak()
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  crypto/aes-helpers.c | 106 +++++++++++++++++++++++++++++++++++++++++++
>  crypto/meson.build   |   1 +
>  include/crypto/aes.h |  14 ++++++

This should be aes-helpers.h, to match the ases-helpers.c
file naming.

>  3 files changed, 121 insertions(+)
>  create mode 100644 crypto/aes-helpers.c
> 
> diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
> new file mode 100644
> index 0000000000..39ca153737
> --- /dev/null
> +++ b/crypto/aes-helpers.c
> @@ -0,0 +1,106 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * AES helper functions and mode implementations
> + *
> + * Authors:
> + *   Harald Freudenberger <freude@linux.ibm.com>
> + */
> +
> +#include <stdint.h>
> +#include <string.h>

Neither of these should be used, instead this should be
including qemu/osdep.h

> +#include "crypto/aes.h"
> +
> +void AES_xor(const unsigned char *src1, const unsigned char *src2,
> +             unsigned char *dst)
> +{
> +    int i;
> +
> +    for (i = 0; i < AES_BLOCK_SIZE; i++) {
> +        dst[i] = src1[i] ^ src2[i];
> +    }
> +}
> +
> +void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
> +                     unsigned char *iv, const AES_KEY *key)
> +{
> +    unsigned char buf[AES_BLOCK_SIZE];
> +
> +    /* in xor iv => buf */
> +    AES_xor(in, iv, buf);
> +    /* encrypt buf => out */
> +    AES_encrypt(buf, out, key);
> +    /* prep iv for next round */
> +    memcpy(iv, out, AES_BLOCK_SIZE);
> +}
> +
> +void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
> +                     unsigned char *iv, const AES_KEY *key)
> +{
> +    unsigned char buf[AES_BLOCK_SIZE];
> +
> +    /* decrypt in => buf */
> +    AES_decrypt(in, buf, key);
> +    /* buf xor iv => out */
> +    AES_xor(buf, iv, out);
> +    /* prep iv for next round */
> +    memcpy(iv, in, AES_BLOCK_SIZE);
> +}
> +
> +void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *ctr, const AES_KEY *key)
> +{
> +    unsigned char buf[AES_BLOCK_SIZE];
> +
> +    /* encrypt ctr => buf */
> +    AES_encrypt(ctr, buf, key);
> +    /* exor input data with encrypted ctr => out */
> +    AES_xor(in, buf, out);
> +}
> +
> +/*
> + * Tweak calculation for AES XTS.
> + * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
> + * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
> + * This implementation has been verified on litte and big endian.
> + */
> +void AES_xts_prep_next_tweak(unsigned char *tweak)
> +{
> +    unsigned char carry;
> +    int i;
> +
> +    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
> +
> +    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
> +        tweak[i] = (unsigned char)((tweak[i] << 1) | (tweak[i - 1] >> 7));
> +    }
> +
> +    tweak[i] = (unsigned char)(tweak[i] << 1);
> +    tweak[i] ^= (unsigned char)(0x87 & (unsigned char)(-(unsigned char)carry));
> +}
> +
> +void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *tweak, const AES_KEY *key)
> +{
> +    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
> +
> +    /* in xor tweak => buf1 */
> +    AES_xor(in, tweak, buf1);
> +    /* encrypt buf1 => buf2 */
> +    AES_encrypt(buf1, buf2, key);
> +    /* buf2 xor tweak => out */
> +    AES_xor(buf2, tweak, out);
> +}
> +
> +void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *tweak, const AES_KEY *key)
> +{
> +    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
> +
> +    /* in xor tweak => buf1 */
> +    AES_xor(in, tweak, buf1);
> +    /* encrypt buf1 => buf2 */
> +    AES_decrypt(buf1, buf2, key);
> +    /* buf2 xor tweak => out */
> +    AES_xor(buf2, tweak, out);
> +}
> diff --git a/crypto/meson.build b/crypto/meson.build
> index b51597a879..675f27311c 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -55,6 +55,7 @@ system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
>  
>  util_ss.add(files(
>    'aes.c',
> +  'aes-helpers.c',
>    'clmul.c',
>    'init.c',
>    'sm4.c',
> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> index 381f24c902..df6239cb9c 100644
> --- a/include/crypto/aes.h
> +++ b/include/crypto/aes.h
> @@ -37,4 +37,18 @@ AES_Td0[x] = Si[x].[0e, 09, 0d, 0b];
>  
>  extern const uint32_t AES_Te0[256], AES_Td0[256];
>  
> +void AES_xor(const unsigned char *src1, const unsigned char *src2,
> +             unsigned char *dst);
> +void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
> +                     unsigned char *iv, const AES_KEY *key);
> +void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
> +                     unsigned char *iv, const AES_KEY *key);
> +void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
> +                      const unsigned char *ctr, const AES_KEY *key);
> +void AES_xts_prep_next_tweak(unsigned char *tweak);
> +void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *tweak, const AES_KEY *key);
> +void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
> +                     const unsigned char *tweak, const AES_KEY *key);

Aside from putting them in aes-helpers.h can you also provide
basic API docs for them inline in the header.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

