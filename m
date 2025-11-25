Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367732BF21
	for <linux-s390@vger.kernel.org>; Tue, 25 Nov 2025 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094287; cv=none; b=q+GQ9hyCjlTnpDudKUZl+0eQEeh9cLjzKqBwv2mjL6XbpDbFj6nkGqHcRLDGFJgk988eWVqBef9H4Q+3Ql148sC/W8Qw95ZM73Na7h0cMv/68qJ98SsT6l8ok+tiJ7pgACJuwHPo5QL0qSk+qwYgEuy/puHG/ofTEBVXcpD1E/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094287; c=relaxed/simple;
	bh=U2rSoMWdIHahvPRPHVndSBa1Y9sUxsWxAxpVFF2VHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP6NjwnAbhGh2QIelf74b37gc84ZRN8iwTfEHKl1Gv/TR/30E0WcDz/8XDtumMzhbGlRvLV1JIaKa0VUy4DIC7gCGUzU7lJxIrZGLdovit1rxYR2jbbLxv4UIfP5qaSbHFhTLIxN0i3aa0V5iwVuOLxRIYJTSlCPrSCP7og9qlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=SNKkStLS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="SNKkStLS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29800ac4ef3so11658945ad.1
        for <linux-s390@vger.kernel.org>; Tue, 25 Nov 2025 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1764094286; x=1764699086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+AG7wRpqHMNfnJeCQpOQEh9m5Efqdn4nU5nA0/8ob0=;
        b=SNKkStLSa7DrbtmT26onhHDHH66P5sLS9Ad01AZlTh/+Q4lTGS08EL+yhHNKgi/TWd
         uaauGtrefhjv1mvNlroGnSQHuDaGAJLzPgMxzskp41mBczAS2o42lWlwgI263P3ge9ge
         wo2EGHL2AyEqVMjpfDQmRzYtchCGDz3XyTNQXcmnVsVNZS0OfO1VXH24SJmUdrHsUNRD
         hMcwQX6LX6vINkCi++4sy+pP35fnaPeitIdSodJkrJjuQU7OoTJNNGvoqMjrNRb5DkME
         7M9pV8J4cWuMLqHdgvsHqlDiaWeqWovSD9AaM9HfJyCG3G7yQxDj0pYTzLg8vPU5hI5W
         WXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094286; x=1764699086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+AG7wRpqHMNfnJeCQpOQEh9m5Efqdn4nU5nA0/8ob0=;
        b=S+tzVUrXd1anCW172bHjwydDRC+BlhZPsg/ePH/PDWsx/JGAheUBx8oiU0uy93tMp6
         uyitxLsFVyeXPSlGAmzDimDaxRKcssjDHSjGaF7D46hoJ/+2Wq00o3yXaqSzPr+EdGe6
         JsaPrzbnuZ3By2+c01MbAmWDNTX+JDevT5JmEDWT4vNiicKyZg4vc9dLPHKrybgchy47
         PPR2siJGu02YEOClSGzQBNksOWvDvVGKlHGpbFiw/pp7aIWIabl4fURus2bB46c3+mUL
         JS//C4RpPEG7rRxVHGREv/WQzbaVOUVinPK6/jwMfa2gCAPIc7KUK+XD+NyhPq9oo0pc
         RwmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvpV2ImOixAUoGM0UjZPl39QuUptMXFXM7pxkH+Rs8bW/oQFsWHAu8RC4RyWvu4wl2AdOYN65hbMym@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7l1S+fr+en0YKu2HANbiu+iaEH7MY9zqvYr5JnJBV+lD6CUT
	TRwhG3eV3bPk21gGdXD3CpXve2cSvPo9mjvgqM+prgfeMPSvj+cN6EqLujjShYD8yvI=
X-Gm-Gg: ASbGncv/8UIvpR6QYXuJvVxZQYeQZi9KoqHHj6Lj4gKeOC/y3k+EzRz9nQhXHkGuqzZ
	FLPzwnNH1X/vbeMj7hMFZscPY6e7NJxiNFWq4u5uXAkasBlShu3h13011I3q9msnFn2d2wOyLm+
	A4JDs8p/J9dP+RSVgxBW+RLFIh78JcfOVR8Ppm21qIm6DtFP42QbXVppeJcNdYkjXsM8DDxtCPz
	If6+6+mRDgA5bnFalIFtpyndK4VoO7w8sRKWNfqCZtx8vLX7DEpIQPqEKwYCp9IT0qFZKu/fj0f
	3SbabwN+O0VdsQ1A1FG+Px3tBEbRN0mIiq0lZvI7DoH6zMmIvr0N8atUJZNJohrozz5i7VHZvSy
	GRkJ5CdaLVKNF4FJEZ46i9ygcZ9GllyRCLw+HrLm0xXf7sOqaLY/sf/KKEVc/v7jqrmdgvLcB
X-Google-Smtp-Source: AGHT+IEBGikt6OJ5HWjVqcKpTHFX0gDBgZQ5MqEUP1FjP7tMlbvmRvYkAvH4AF2C4YKp+tr7YiXW9w==
X-Received: by 2002:a17:902:ef08:b0:266:914a:2e7a with SMTP id d9443c01a7336-29b70255276mr91488805ad.6.1764094285502;
        Tue, 25 Nov 2025 10:11:25 -0800 (PST)
Received: from t14 ([2001:5a8:47ec:d700:7dee:b1a1:fd3f:6b76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bf60csm173038775ad.101.2025.11.25.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:11:25 -0800 (PST)
Date: Tue, 25 Nov 2025 10:11:23 -0800
From: Jordan Rife <jordan@jrife.io>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for
 bpf_tracing_link_lops
Message-ID: <mlzsxvgexxalfqxgszivdrg2vuiadtxfydg4p4bvfqpj2wqjep@v5tkqwnlfohy>
References: <20251118005305.27058-1-jordan@jrife.io>
 <20251118005305.27058-2-jordan@jrife.io>
 <aSCUrtsBrfS2iTkB@krava>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSCUrtsBrfS2iTkB@krava>

On Fri, Nov 21, 2025 at 05:34:54PM +0100, Jiri Olsa wrote:
> On Mon, Nov 17, 2025 at 04:52:53PM -0800, Jordan Rife wrote:
> 
> SNIP
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index f62d61b6730a..b0da7c428a65 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -63,6 +63,8 @@ static DEFINE_IDR(map_idr);
> >  static DEFINE_SPINLOCK(map_idr_lock);
> >  static DEFINE_IDR(link_idr);
> >  static DEFINE_SPINLOCK(link_idr_lock);
> > +/* Synchronizes access to prog between link update operations. */
> > +static DEFINE_MUTEX(trace_link_mutex);
> >  
> >  int sysctl_unprivileged_bpf_disabled __read_mostly =
> >  	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
> > @@ -3562,11 +3564,77 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
> >  	return 0;
> >  }
> >  
> > +static int bpf_tracing_link_update_prog(struct bpf_link *link,
> > +					struct bpf_prog *new_prog,
> > +					struct bpf_prog *old_prog)
> > +{
> > +	struct bpf_tracing_link *tr_link =
> > +		container_of(link, struct bpf_tracing_link, link.link);
> > +	struct bpf_attach_target_info tgt_info = {0};
> > +	int err = 0;
> > +	u32 btf_id;
> > +
> > +	mutex_lock(&trace_link_mutex);
> 
> that seems too much, we could add link->mutex

This penalizes all links though. Scanning through some other link types
in the kernel, most that I see that support update_prog have opted for a
global mutex as opposed to a per-link mutex. To me, it seems better to
go with this since contention is low instead of making link structs
bigger?
 
> > +
> > +	if (old_prog && link->prog != old_prog) {
> > +		err = -EPERM;
> > +		goto out;
> > +	}
> > +	old_prog = link->prog;
> > +	if (old_prog->type != new_prog->type ||
> > +	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&new_prog->aux->dst_mutex);
> > +
> > +	if (!new_prog->aux->dst_trampoline ||
> > +	    new_prog->aux->dst_trampoline->key != tr_link->trampoline->key) {
> 
> hum, would be easier (and still usefull) to allow just programs for the same function?

This behavior mirrors that of bpf_tracing_prog_attach below. I think
you'd lose some utility if you required dst_trampoline to match
trampoline here. A practical use case I can think of would be that you
might want to reuse the same program for several links or
detach/reattach the same program. In these scenarios, dst_trampoline
would have been cleared previously, so you'd need to do the
compatibility check again.
 
> > +		bpf_trampoline_unpack_key(tr_link->trampoline->key, NULL,
> > +					  &btf_id);
> > +		/* If there is no saved target, or the target associated with
> > +		 * this link is different from the destination specified at
> > +		 * load time, we need to check for compatibility.
> > +		 */
> > +		err = bpf_check_attach_target(NULL, new_prog, tr_link->tgt_prog,
> > +					      btf_id, &tgt_info);
> > +		if (err)
> > +			goto out_unlock;
> > +	}
> > +
> > +	err = bpf_trampoline_update_prog(&tr_link->link, new_prog,
> > +					 tr_link->trampoline);
> > +	if (err)
> > +		goto out_unlock;
> > +
> > +	/* Clear the trampoline, mod, and target prog from new_prog->aux to make
> > +	 * sure the original attach destination is not kept alive after a
> > +	 * program is (re-)attached to another target.
> > +	 */
> > +	if (new_prog->aux->dst_prog)
> > +		bpf_prog_put(new_prog->aux->dst_prog);
> > +	bpf_trampoline_put(new_prog->aux->dst_trampoline);
> 
> would it be possible just to take tr->mutex and unlink/link
> the programs, something like:
> 
>         mutex_lock(&tr->mutex);
> 
> 	__bpf_trampoline_unlink_prog(old_prog)
> 	__bpf_trampoline_link_prog(new_prog)
> 
>         mutex_unlock(&tr->mutex);

This is non-atomic though, so there would be some period between unlink
and link where the link target's trampoline doesn't have the program:

[old_prog]
[] <-
[new_prog]

Maybe it's not such a big deal for pure tracing stuff like fentry/fexit,
but it could create some weird and unexpected effects with freplace
links. Unfortunately, to guarantee atomicity, I think you have to push
the intent to actually update a specific program in a trampoline down a
layer (i.e. bpf_trampoline_update_prog).
  
> I might be missing something but this way we wouldn't need
> the arch chages in the following patches?

Alexei said he doesn't want to support update_prog for fentry/fexit;
dropping that from this series (patches 3-6) would remove arch-specific
stuff.

> jirka
> 
> 
> > +	module_put(new_prog->aux->mod);
> > +
> > +	new_prog->aux->dst_prog = NULL;
> > +	new_prog->aux->dst_trampoline = NULL;
> > +	new_prog->aux->mod = tgt_info.tgt_mod;
> > +	tgt_info.tgt_mod = NULL; /* Make module_put() below do nothing. */
> > +out_unlock:
> > +	mutex_unlock(&new_prog->aux->dst_mutex);
> > +out:
> > +	mutex_unlock(&trace_link_mutex);
> > +	module_put(tgt_info.tgt_mod);
> > +	return err;
> > +}
> > +
> >  static const struct bpf_link_ops bpf_tracing_link_lops = {
> >  	.release = bpf_tracing_link_release,
> >  	.dealloc = bpf_tracing_link_dealloc,
> >  	.show_fdinfo = bpf_tracing_link_show_fdinfo,
> >  	.fill_link_info = bpf_tracing_link_fill_link_info,
> > +	.update_prog = bpf_tracing_link_update_prog,
> >  };
> >  
> 
> SNIP

Thanks for taking a look!

Jordan
