Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAF43713B
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529652; cv=none; b=BHtIiIbv6qIC7YQgmt1CqGJdZ9SOVpiwdOAPfqT4tFEPn7sOBVang38bXaE/LVAASZXEggr/xnkfkISwOValf2CIKSAU6dUDVOwnA1Br9OqV/jv3URIxyWVDgoDnCHpTFefI8Hq1Yk5VucB6Wo+T4G8C9yhm0YhB/Gb/fqiGUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529652; c=relaxed/simple;
	bh=+X2XoakxjrE4901SuEHxhCt+vF47bmpYALuBrqQN69w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SREM5eRyZ2Xxnt5UkJ17BiJSfvTIlmBsYaOCOpJWjfIJQQ3jmuRxL/JWVi/ulL4XRlCsemIc0IQJgy2n/9A2rxBW/Pn94LdvTKT3J1a9Gz2Qurtp2IfqJmMWsitySUjVkEG2QzH6b3xcNf4CpfjEn7CLqKetq2WmsHhftjP0jlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJS08DgO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJS08DgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783529650;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=uk/Y2xrpjQV1SX/sXmbxHPgM1l1KyvAF/CWz0zbwGEg=;
	b=iJS08DgOs1jEwQzR3N25ciG5hTDvOTqyvHjxGcct2BC9MqdMlPebA1D8ljRttnjWlNJfvK
	muTgzd+za3S/pFwAPPk04WFiAjM5fNjrYGiaFN32GOdA/Ri2bzhkXkomsLSe2OwFoA/l4c
	hyR5w2M6jegFYD4oeCQ1+kSXNB2decw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-gjGEuxX5NsaFi_6tMA-x-g-1; Wed,
 08 Jul 2026 12:54:06 -0400
X-MC-Unique: gjGEuxX5NsaFi_6tMA-x-g-1
X-Mimecast-MFC-AGG-ID: gjGEuxX5NsaFi_6tMA-x-g_1783529645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B230E180AE16;
	Wed,  8 Jul 2026 16:54:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C281800591;
	Wed,  8 Jul 2026 16:53:55 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:53:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
	thuth@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
	linux-s390@vger.kernel.org, dengler@linux.ibm.com,
	borntraeger@linux.ibm.com, fcallies@linux.ibm.com,
	cohuck@redhat.com
Subject: Re: [PATCH v11 19/21] target/s390x: Use generic AES helper functions
Message-ID: <ak6AoBLuS5PZmOB6@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-20-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707161815.40919-20-freude@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jul 07, 2026 at 06:18:06PM +0200, Harald Freudenberger wrote:
> Rewrite the cpacf implementations to use the generic
> AES helper functions from crypto/aes-helpers.c

The aes-helper.c addition should be done at the start of this series,
and then the impls can use the AES helpers right from the start.

This avoids the reviewers having to review code that is never merged
due to being replaced in this patch.

> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>  target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
>  1 file changed, 36 insertions(+), 88 deletions(-)
> 
> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index 4449bbc0d2..e9f0db2b5a 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -110,20 +110,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      return !len ? 0 : 3;
>  }
>  
> -static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
> -{
> -    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
> -        dst[i] = src1[i] ^ src2[i];
> -    }
> -}
> -
>  int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *dst_ptr_reg,
>                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>                    uint32_t type, uint8_t fc, uint8_t mod)
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> -    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>      uint64_t addr, len = *src_len_reg, done = 0;
>      int i, keysize, addr_reg_size = 64;
> @@ -179,19 +172,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>          if (mod) {
> -            /* decrypt in => buf */
> -            AES_decrypt(in, buf, &exkey);
> -            /* buf xor iv => out */
> -            aes_xor(buf, iv, out);
> -            /* prep iv for next round */
> -            memcpy(iv, in, AES_BLOCK_SIZE);
> +            /* decrypt in => out */
> +            AES_cbc_decrypt(in, out, iv, &exkey);
>          } else {
> -            /* in xor iv => buf */
> -            aes_xor(in, iv, buf);
> -            /* encrypt buf => out */
> -            AES_encrypt(buf, out, &exkey);
> -            /* prep iv for next round */
> -            memcpy(iv, out, AES_BLOCK_SIZE);
> +            /* encrypt in => out */
> +            AES_cbc_encrypt(in, out, iv, &exkey);
>          }
>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
> @@ -221,11 +206,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> -    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>      uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>      uint64_t addr, len = *src_len_reg, done = 0;
> +    uint8_t ctr[AES_BLOCK_SIZE], key[32];
>      int i, keysize, addr_reg_size = 64;
> -    uint8_t key[32];
>      AES_KEY exkey;
>  
>      g_assert(type == S390_FEAT_TYPE_KMCTR);
> @@ -267,12 +251,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
>          /* read in nonce/ctr => ctr */
>          aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
> -        /* encrypt ctr => buf */
> -        AES_encrypt(ctr, buf, &exkey);
>          /* read in one block of input data => in */
>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
> -        /* xor input data with encrypted ctr => out */
> -        aes_xor(in, buf, out);
> +        /* encrypt ctr and xor with in => out */
> +        AES_ctr_encrypt(in, out, ctr, &exkey);
>          /* write out the processed block */
>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
> @@ -353,28 +335,13 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      return 0;
>  }
>  
> -static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
> -{
> -    uint8_t carry;
> -    int i;
> -
> -    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
> -
> -    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
> -        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
> -    }
> -
> -    tweak[i] = (uint8_t)(tweak[i] << 1);
> -    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
> -}
> -
>  int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *dst_ptr_reg,
>                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>                    uint32_t type, uint8_t fc, uint8_t mod)
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> -    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>      uint64_t addr, len = *src_len_reg, done = 0;
>      uint8_t key[32], tweak[AES_BLOCK_SIZE];
> @@ -425,23 +392,19 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>  
>      /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> -        /* fetch one AES block into buf1  */
> -        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
> -        /* buf1 xor tweak => buf2 */
> -        aes_xor(buf1, tweak, buf2);
> +        /* fetch one AES block into in  */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>          if (mod) {
> -            /* decrypt buf2 => buf1 */
> -            AES_decrypt(buf2, buf1, &exkey);
> +            /* decrypt in => out */
> +            AES_xts_decrypt(in, out, tweak, &exkey);
>          } else {
> -            /* encrypt buf2 => buf1 */
> -            AES_encrypt(buf2, buf1, &exkey);
> +            /* encrypt in => out */
> +            AES_xts_encrypt(in, out, tweak, &exkey);
>          }
> -        /* buf1 xor tweak => buf2 */
> -        aes_xor(buf1, tweak, buf2);
>          /* prep tweak for next round */
> -        aes_xts_prep_next_tweak(tweak);
> -        /* write out this processed block from buf2 */
> -        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
> +        AES_xts_prep_next_tweak(tweak);
> +        /* write out this processed block from out */
> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
>          done += AES_BLOCK_SIZE;
>      }
> @@ -637,7 +600,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                     uint32_t type, uint8_t fc, uint8_t mod)
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> -    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>      uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
>      uint64_t addr, len = *src_len_reg, done = 0;
> @@ -705,19 +668,11 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>          if (mod) {
> -            /* decrypt in => buf */
> -            AES_decrypt(in, buf, &exkey);
> -            /* buf xor iv => out */
> -            aes_xor(buf, iv, out);
> -            /* prep iv for next round */
> -            memcpy(iv, in, AES_BLOCK_SIZE);
> +            /* decrypt in => out */
> +            AES_cbc_decrypt(in, out, iv, &exkey);
>          } else {
> -            /* in xor iv => buf */
> -            aes_xor(in, iv, buf);
> -            /* encrypt buf => out */
> -            AES_encrypt(buf, out, &exkey);
> -            /* prep iv for next round */
> -            memcpy(iv, out, AES_BLOCK_SIZE);
> +            /* encrypt in => out */
> +            AES_cbc_encrypt(in, out, iv, &exkey);
>          }
>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
> @@ -747,11 +702,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> -    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>      uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> +    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
>      uint64_t addr, len = *src_len_reg, done = 0;
>      int i, keysize, addr_reg_size = 64;
> -    uint8_t key[32], wkvp[32];
>      AES_KEY exkey;
>  
>      g_assert(type == S390_FEAT_TYPE_KMCTR);
> @@ -805,12 +759,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
>          /* read in nonce/ctr => ctr */
>          aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
> -        /* encrypt ctr => buf */
> -        AES_encrypt(ctr, buf, &exkey);
>          /* read in one block of input data => in */
>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
> -        /* exor input data with encrypted ctr => out */
> -        aes_xor(in, buf, out);
> +        /* encrypt ctr and xor with in => out */
> +        AES_ctr_encrypt(in, out, ctr, &exkey);
>          /* write out the processed block */
>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
> @@ -911,7 +863,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                     uint32_t type, uint8_t fc, uint8_t mod)
>  {
>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> -    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>      uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
>      uint64_t addr, len = *src_len_reg, done = 0;
> @@ -974,23 +926,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>  
>      /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> -        /* fetch one AES block into buf1  */
> -        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
> -        /* buf1 xor tweak => buf2 */
> -        aes_xor(buf1, tweak, buf2);
> +        /* fetch one AES block into in */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>          if (mod) {
> -            /* decrypt buf2 => buf1 */
> -            AES_decrypt(buf2, buf1, &exkey);
> +            /* decrypt in => out */
> +            AES_xts_decrypt(in, out, tweak, &exkey);
>          } else {
> -            /* encrypt buf2 => buf1 */
> -            AES_encrypt(buf2, buf1, &exkey);
> +            /* encrypt in => out */
> +            AES_xts_encrypt(in, out, tweak, &exkey);
>          }
> -        /* buf1 xor tweak => buf2 */
> -        aes_xor(buf1, tweak, buf2);
>          /* prep tweak for next round */
> -        aes_xts_prep_next_tweak(tweak);
> -        /* write out this processed block from buf2 */
> -        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
> +        AES_xts_prep_next_tweak(tweak);
> +        /* write out this processed block from out */
> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>          len -= AES_BLOCK_SIZE;
>          done += AES_BLOCK_SIZE;
>      }
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

