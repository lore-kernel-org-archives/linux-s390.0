Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166E1E5207
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901632; cv=none; b=WJU+1wxZ3GvvQqOzgLbirjb4n1vSOpUnWlWQv5v3md6qb967MIcDSAh30oxoENFomVgIjC0Jdwuy45GwZciSzJmgR9b8PBqDbmlKjayOyJus7n+nKDSvs7xn7t103IC0y9j/e7m1Q9ujWLbpPPgURgD14R3RMOvh0bIQxpX8NWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901632; c=relaxed/simple;
	bh=HsxQLplX9ZupAdG6x61z6GQ0vJcOUthh3GHiJgQdS3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNaV6fCBmgGoHoAiMmNC4UH+Wqqny9wpIenq7YHF0D8MIz5EJISoOkVUhQgN4qNpQziXlydWUe5lHEX3hnGjYn+zF5RyJv2PVtKUczSNbS4YWbNYVad4eihxglopuvCocMSoVHg+PX/c72HAr1J07jadTjrb7sBXZR0u3BDoaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjhmKYeu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjhmKYeu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771901618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzkqY8CkKpY6s/bTgMtaexs4DIId6SrfZ+UYAFGY1k8=;
	b=IjhmKYeuygewBF1EdnI2AQH0YEroTMroCP6VI18Sy/yATK1DJCgGbS8r9F1EL0b+8W6bAx
	v+FiyKkjjtXacK9LYXf8UVp2xgrh5EhEYY0y3Ws5MZF2T8JDoVtOjZv1EQpiKDmtzEvdD5
	LmbZ20/pS/9KhVyexI0t4rHbbwVCTCE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next 2/3] bpf,s390: add fsession support for trampolines
Date: Tue, 24 Feb 2026 10:53:18 +0800
Message-ID: <9580160.CDJkKcVGEf@7940hx>
In-Reply-To: <10367bd9-4b9f-48d1-9ee7-8e8b1ec57909@linux.ibm.com>
References:
 <20260223084022.653186-1-dongml2@chinatelecom.cn>
 <20260223084022.653186-3-dongml2@chinatelecom.cn>
 <10367bd9-4b9f-48d1-9ee7-8e8b1ec57909@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/23 20:14 Ilya Leoshkevich <iii@linux.ibm.com> write:
> 
> On 2/23/26 09:40, Menglong Dong wrote:
> > Implement BPF_TRACE_FSESSION support for s390. The logic here is similar
> > to what we did in x86_64.
> >
> > In order to simply the logic, we factor out the function invoke_bpf() for
> > fentry and fexit.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >   arch/s390/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++++++-----
> >   1 file changed, 59 insertions(+), 9 deletions(-)
> 
> 
> Thank you for contributing this series!
> 
> 
> In general this all looks very reasonable; I believe I found a few nits, 
> please take a look at my comments below.
> 
> 
> >
> > diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> > index 763d2491dfa3..ea0c81f18ece 100644
[...]
> >   
> > -	for (i = 0; i < fentry->nr_links; i++)
> > -		if (invoke_bpf_prog(tjit, m, fentry->links[i],
> > -				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
> > +	if (fsession_cnt) {
> > +		/* clear all the session cookies' value */
> 
> Here and below: please use the existing style for single-line comments: 
> full sentence starting with a capital letter and ending with a dot. 
> Unfortunately the JIT is somewhat inconsistent in this area, but let's 
> at least not introduce a new comment style here.

OK, I'll fix up the comments style in the next version.

> 
> > +		for (i = 0; i < cookie_cnt; i++)
> > +			emit_store_stack_imm64(jit, REG_0, cookie_off + 8 * i, 0);
> > +		/* clear the return value to make sure fentry always gets 0 */
> > +		emit_store_stack_imm64(jit, REG_0, tjit->retval_off, 0);
> > +	}
> 
> Would it make sense to clear cookies right after invoke_bpf_prog() and 
> only if bpf_prog_calls_session_cookie() is true?

I think it doesn't make much sense. We only reserve session cookies for
the fsession progs that called bpf_session_cookie(), which means that
all the cookies that we reserved here will be used. Right?

> 
> Going one step further and reducing the size of cookies array would 
> probably be ideal, but I guess this will complicate things 
> significantly, so I'm not suggesting to do this.
> 
> > +
> > +	if (fentry->nr_links) {
> 
> I think it's okay to drop this condition, invoke_bpf() is most likely 
> inlined and the loop will automatically have 0 iterations in this case.

OK, I'll drop this checking.

> 
> > +		if (invoke_bpf(tjit, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
> > +			       func_meta, cookie_off))
> >   			return -EINVAL;
> > +	}
> >   
> >   	if (fmod_ret->nr_links) {
> >   		/*
> > @@ -2842,11 +2880,18 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
> >   		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
> >   	}
> >   
> > +	/* set the "is_return" flag for fsession */
> > +	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
> > +	if (fsession_cnt)
> > +		emit_store_stack_imm64(jit, REG_W0, tjit->func_meta_off,
> > +				       func_meta);
> > +
> >   	/* do_fexit: */
> >   	tjit->do_fexit = jit->prg;
> > -	for (i = 0; i < fexit->nr_links; i++)
> > -		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
> > +	if (fexit->nr_links) {
> Same as for fentry.

ACK.

Thanks!
Menglong Dong

> > +		if (invoke_bpf(tjit, m, fexit, false, func_meta, cookie_off))
> >   			return -EINVAL;
> > +	}
> >   
> >   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> >   		im->ip_epilogue = jit->prg_buf + jit->prg;
> > @@ -2951,6 +2996,11 @@ bool bpf_jit_supports_arena(void)
> >   	return true;
> >   }
> >   
> > +bool bpf_jit_supports_fsession(void)
> > +{
> > +	return true;
> > +}
> > +
> >   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
> >   {
> >   	if (!in_arena)
> 
> 




