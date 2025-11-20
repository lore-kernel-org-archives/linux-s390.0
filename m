Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33913019B4
	for <linux-s390@vger.kernel.org>; Thu, 20 Nov 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666601; cv=none; b=rofMAv9svgkU3aViTVtIqqe4Ah9bL081xOWOBMD+JnnSFHWyyfitkHpQgrE+TVd5EWAffkzaY806a+deNfcHP+TpjVQaPb+qnUZjvVOZtZ9mXi5pN3gQIkK5/A0utLNx1GLvifW524u66G28rWMGeALzgczTpyynmIv4iQNXr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666601; c=relaxed/simple;
	bh=hPQ1Fe33RuAb47Iab6vNkYNQvZXNkuae4XRditaPdl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwPEG14q4wPomca+09aZb3BL3ClQMyjaGEsjB2Q+evzsJl6X27xOMfoITCRtKC3kuHQMRV9aThmCT3yenx2CIsmcWVprVbNH1vjmhE1bLLPMx+SKUOjfVjWJ305v0azP70YAnE8uWosCMh8aJ7fEguvFPd4rEVeADB9ek0xLLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=IsZvqSNA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="IsZvqSNA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-299e43c1adbso1609005ad.3
        for <linux-s390@vger.kernel.org>; Thu, 20 Nov 2025 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763666599; x=1764271399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8QsP0PxfZWQK7EEkk/D6jF94UJEcsiLhTO6sey741I=;
        b=IsZvqSNArPfqukwy1BKknjL/aI1eIugYltjuvyH5GlXS2Ku9K0rpZEjI8n6xQRy5Lg
         S4/H4fuxixnffD7jqjW7bvO0X1okD+oz/+nJvNu4bYkrRfVQ4Clmd/AeD6CCXA2mxVA4
         DyDZkWyARKK5B0fWW7KcRsj5+9FlF9+rPysUZLLowWEgoKrcObThj8H4Uy2C44ZwntvM
         xeAksFXPvlPrfNsd4j9Hau9UM3KucB+YRDjBX0WUtd0v9VWrbjAF9T5ZGnyAFKOEfcOZ
         CkcGvmDQaqqKIgt0e+/cg18DTe6lqqxSG7Gcm8ERie8tpxNkQ7KybOrxXrwVijOP0rSJ
         tjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666599; x=1764271399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8QsP0PxfZWQK7EEkk/D6jF94UJEcsiLhTO6sey741I=;
        b=qtYldT58WRBjBMPOXln28vrKnMNYHl8F6qtpBxjQq706ZKeL6vOupIhTY/xUj7f5zc
         Pz6deW5/yyjVGXQZDA4Po9zkXO+aXAVftvkQGY1HGSSWvNjQooMx9Lr19MULuZIA8N6y
         LoOXotCmpMT/iRYo3Y0GePS76jqLBdf04YKyULxoDN77cKiPo9Rx8dtvAimqVtiv4etB
         nZCgZLwbj5FJ15OU+bCTB+Oibz5xl7dAm26wGyjIXg7i48Tw5OdBxwofAhaQg3Xol4zM
         xRFnAZttfhtw6tSMobSdFqryxI5Abod3pZ/cqtXYd9t5Ce0bAQ7luqqJYW94pUXwBBAp
         Qu0A==
X-Forwarded-Encrypted: i=1; AJvYcCUWsU3/fegtwom2VjI/Q0by3q136lbgDDJp4zIwVRCe2P/OKla3E7UY99FcNsBBDwNlVhFJbxoSTlZg@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUlViGWgxoZ20nQQysQ2fs0En4BBknHsHdoDc3v/Jq0F4EmlR
	RWzXV+8a5D9E5j5XOXpwD21N79G0rduPvH1jB6pm6RcLsKPR7VFVS5ABKOqoCbrvuoA=
X-Gm-Gg: ASbGncufGFHfVNW9z/HuuSKrmx8ZLhEMLYRp91mv+P3pqO3HFtDbe0Y+/rci0s4/2j2
	5dpFiVCRn3cwtK6mpYBXgVsgD3dxgf03BHYgONUb9bJzyHJYpEjpSEZwHszL7tVSDCXWE4ZqDeI
	Gaamv43B2i/0aWNwUbS7voF92hOrbwHLw2enTT+0OW81lJouI6cSoYWYpR5IBvC1aJeFALyKg1P
	qCjixwCUf5g0S9ufJxw3U6vNn60xo075MDJIyzXD3S0fJSBCofYPzq531faIok1oF4GQFV2Gh00
	S1wC2TLtXMMUT7dHVwndbJEMBJ6JSPsxgQRUz5+Om1VE6tqq4MhVvGkHJDmFwFzWOKPFtRLA8+a
	EZeVRCdH9tN3yrOjD+euo7B8m+HmeDhrCrbsJpUQp1kHC5ch8J7QmdkOzl4fetDwVqFNYzrYG
X-Google-Smtp-Source: AGHT+IHTgAAGIpuLMfi3qOYAUFJkNfXklq8UcLL7eoIA/fJXTZdw0H4yCNcTl1RjJj1OExsn5zv8gg==
X-Received: by 2002:a17:902:cf0e:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-29b5ecb6362mr28916435ad.0.1763666599230;
        Thu, 20 Nov 2025 11:23:19 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:51d0:d4a0:ba29:b604])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm33489305ad.25.2025.11.20.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:23:18 -0800 (PST)
Date: Thu, 20 Nov 2025 11:23:14 -0800
From: Jordan Rife <jordan@jrife.io>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, puranjay@kernel.org, iii@linux.ibm.com, 
	mingo@redhat.com, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for
 bpf_tracing_link_lops
Message-ID: <2wc6cxyfuw77dpd3tobt7w4tpdlon4zysjky4gpomj6w2tyusa@mnem7dwqzmip>
References: <20251118005305.27058-2-jordan@jrife.io>
 <ad3ea8d7ccb10a7972db01b58d2596b425d60718ec09450a1ed6d7839488af51@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3ea8d7ccb10a7972db01b58d2596b425d60718ec09450a1ed6d7839488af51@mail.kernel.org>

On Tue, Nov 18, 2025 at 01:27:45AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 09d5dc541..23fcbcd26 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a2a441185..14dd8be7b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 04104397c..d2fd02e10 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -607,6 +607,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> >  	return err;
> >  }
> >
> > +static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> > +					struct bpf_prog *new_prog,
> > +					struct bpf_trampoline *tr)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> > +int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> > +			       struct bpf_prog *new_prog,
> > +			       struct bpf_trampoline *tr)
> > +{
> > +	struct bpf_prog *old_prog;
> > +	int err;
> > +
> > +	mutex_lock(&tr->mutex);
> > +	err = __bpf_trampoline_update_prog(link, new_prog, tr);
> > +	if (!err) {
> > +		/* If a program update was successful, switch the program
> > +		 * in the link before releasing tr->mutex; otherwise, another
> > +		 * operation could come along and update the trampoline with
> > +		 * the link still pointing at the old program.
> > +		 */
> > +		old_prog = xchg(&link->link.prog, new_prog);
> > +		bpf_prog_put(old_prog);
> > +	}
> > +	mutex_unlock(&tr->mutex);
> > +	return err;
> > +}
> > +
> 
> Can bpf_prog_put() be called while holding tr->mutex?
> 
> When bpf_prog_put()->__bpf_prog_put() drops the program's refcount to
> zero and we're not in IRQ context (which we aren't when holding a regular
> mutex), it directly calls bpf_prog_put_deferred(). This eventually calls
> bpf_trampoline_put(), which takes trampoline_mutex.

The only code path I see where this is true is where
bpf_prog_put_deferred may eventually lead to this line in
bpf_prog_free_deferred:

	if (aux->dst_trampoline)
		bpf_trampoline_put(aux->dst_trampoline);

In this case though aux->dst_trampoline would have been cleared in
bpf_tracing_link_update_prog or bpf_tracing_prog_attach so this code
path wouldn't run.

> The existing code in bpf_trampoline_link_cgroup_shim() carefully unlocks
> tr->mutex before calling bpf_trampoline_put() (see the comment "have to
> release tr while _not_ holding its mutex"). Additionally,
> bpf_trampoline_put() has WARN_ON_ONCE(mutex_is_locked(&tr->mutex)) to
> catch this pattern.
> 
> Should bpf_prog_put() be moved after mutex_unlock(&tr->mutex)?

I don't see how a deadlock could occur in this scenario, but I could
move it after mutex_unlock() to remove any doubt.
 
> >  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
> >  					struct bpf_trampoline *tr,
> >  					struct bpf_prog *tgt_prog)
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19450205468

