Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A989146A6F;
	Mon, 24 Mar 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849975; cv=none; b=ru5fJTCrkMEZtNahC4mSn3ObAULoS2/W/9rg77YwjRPpMLB9t9oB/vwgAIKDXn6+oDBctf5McE+YbaDEltRKRTfPgLV6lzppIKHlwhUEZUlAI+ZjLjgmRGWkRwsQg9Orw+l+Q2rQFUl3HWxxLyDiz4+gpQK+z4m4UKwVQq8tl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849975; c=relaxed/simple;
	bh=Mwkg0B1Hit+qR5HQ7rJJsjuL0ax8lpEZW+1GiIODyl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWhlsIqxUFT/LcvkyaWvxR/4vnRtCYPkFWQ9irMClrIa5G15Su0dOYjj/O0JHozSRUeaDsVeDNVhuZrSHgFsI9Oyzh8Oz3NArqlExXEOqHyARo9b5w0bmNOq5Ao0hubz3Innv1RAFwQxvvjo06O8rJpo5ti1VfD7ktHjT5M+lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmKHpNaO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmKHpNaO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so20405325ad.0;
        Mon, 24 Mar 2025 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849973; x=1743454773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYyFK3qdUCySJFOy6rGMp+fHWi0RrQ8cewqrFcn0kdw=;
        b=VmKHpNaO8lK4/YSglvQciuYtFv/KKVChbt7jNU156iE1ePOrJHp4TZVdSwnCoXs1hv
         f1M5ZwmKK4OB9wingXkl3Jj+zg5W6uMPCJnjuCvRcgAdfzAgk79JiIx5AIgxr3uyhOGK
         y0wIdvsBbwwSAmUz8aEVpk1hI4XPE9DWCmRgx6dw/g96yLRaW1x2e/J0lj7LQxyZUnQU
         jMmngV7/iV0XapMZZF9X85HxiamfeZmK1TobXXFVhi9VqxCyJ0ST7InBXEbivn0IUY2U
         uL5XqrOhyz6Xm+W5Xf3fkOD51Q+jsfT7n11uGUVTpdgbfO3K9nj8EmoBp7E/iHifhzGS
         ZZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849973; x=1743454773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYyFK3qdUCySJFOy6rGMp+fHWi0RrQ8cewqrFcn0kdw=;
        b=SViQb12eE0SpEIc5/+K65BhuTwzOCgd1Gc+wUnh/a0vetF8NCj1u9Sh6Nw0j/Yb3Fu
         wLw661z+YBtOSBXHWMBmPZWT5jt+SaQKJIRuDP1EfOeG1C/8zjEiFVEM0gMGTU6dx4kD
         N1KLlwI4zTAojvsR7xBt1gRrEGWzpjDfUgUpjiDg5z9XBwpw2vKP8gDKVEZ41yDx4MHp
         AzaPit1FU+ctAqWaMnzpGOUHgnHn4oKX686nA7GvVcmJ3NB7rBe42jn+5IkqahNOW4BV
         DOawBttYsDwFp33na/ZdwIau6UeToKouL9kPTjwetbbkbS7lKNQf41rsb0QLL6oOO33Y
         Bvpw==
X-Forwarded-Encrypted: i=1; AJvYcCU5k3UcxhWK0Pg5D5GTZ/jzAefke3fRbrupNdYloUOMGIMijYJREer8RkR1FaoA+s5AEnlXlOYr4KIocjuvZiZfVw==@vger.kernel.org, AJvYcCVCfaUsq7ePL1S1F7tPE48dvtkXyHMEHJfkv+k+vno+Qxbn3aZoFkFnqF3uNZ0dlyBkIBVGVAF44DLe3w==@vger.kernel.org, AJvYcCWOH8ElEtEDtDe85Ng7Ixowbvyeuv2AskDGbWdO8qSUBIZWrj5Uz1DTkEmamNpZm3PZrQJ9ooMVxUSBchU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lsFHI+F0W9EaNkCDWSAf0E3Rv0GAT95hgmlEHzjUNdMMDjTd
	BTTFqfnhKBITYfnSfidpVimhC+bGmSj3X5/89TBrSZgelUBfhnVU
X-Gm-Gg: ASbGncvOQRetHh0mWrcy8jX2RpKwq0wfEkIoBr7pF+0Y5EjEgRqN0pOQ6uprb7v2GD+
	22uvCrtNivOxMDaaGozd/2MwFLM5PaHXZOm0sZW6RQ4HNwVz1m+DuIkm9ss0cjAZR6pfy3dBIXF
	AiWZb/rzuUpbE0KH91Q13+s0AHA4NF/XdWufgDIeo4UUCuKXuttfB0EcqCapTEEW1H5RmZjqrjA
	9lbhvlyjJUS2HpEtCLzXRiv9waDDV5CyfqFIV5bcQvTxkNSEM9nGYuPDwWpje9VVFEPyMdn6djd
	zGpLU2SRww+OqKAMboja4ZiBMhkEvd78RunLHgSrPCTEHEAdupmDlgfXbFowOuvbEHInUhSqrSZ
	bKJQ=
X-Google-Smtp-Source: AGHT+IEMvOe03VOrKdxt5MZfTJRIZURstb5e8Y0X2Si45X0ViJoCHxiLI0q34VvED7Iz3B39Bn5wVQ==
X-Received: by 2002:a17:902:ea03:b0:220:f795:5f14 with SMTP id d9443c01a7336-22780d8fbccmr199537305ad.27.1742849972489;
        Mon, 24 Mar 2025 13:59:32 -0700 (PDT)
Received: from gmail.com (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f455a8sm75936665ad.55.2025.03.24.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:59:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:59:29 -0700
From: Howard Chu <howardchu95@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	acme@kernel.org, namhyung@kernel.org, james.clark@linaro.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
Message-ID: <Z-HHscQ_T6vLZ_-N@gmail.com>
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
 <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
 <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU+9EQKT2fOuBQ5ds6s4Bh6rWrvco1ow6B-CQ92XuO1kQ@mail.gmail.com>


Hello Ian,

On Mon, Mar 24, 2025 at 08:50:36AM -0700, Ian Rogers wrote:
> On Mon, Mar 24, 2025 at 8:38 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 8:28 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > >
> > > In linux-next
> > > commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> > > causes the perf tests 100 126 to fail on s390:
> > >
> > > Output before:
> > >  # ./perf test 100
> > >  100: perf trace BTF general tests         : FAILED!
> > >  #
> > >
> > > The root cause is the change from int to int16_t for the
> > > cpu maps. The size of the CPU key value pair changes from
> > > four bytes to two bytes. However a two byte key size is
> > > not supported for bpf_map__update_elem().
> >
> > Nice catch!
> >
> > > Note: validate_map_op() in libbpf.c emits warning
> > >  libbpf: map '__augmented_syscalls__': \
> > >          unexpected key size 2 provided, expected 4
> > > when key size is set to int16_t.
> >
> > Wow, weird.
> 
> Ah, I guess it is a mismatch with the declaration in
> tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c?h=perf-tools-next#n31
> ```
> /* bpf-output associated map */
> struct __augmented_syscalls__ {
>        __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>        __type(key, int);
>        __type(value, __u32);
>        __uint(max_entries, MAX_CPUS);
> } __augmented_syscalls__ SEC(".maps");
> ```
> but this looks wrong. The values are file descriptors, so should be
> ints. I think it should be:
> ```
> struct __augmented_syscalls__ {
>        __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>        __type(key, int16_t);
>        __type(value, int);
>        __uint(max_entries, MAX_CPUS);
> } __augmented_syscalls__ SEC(".maps");
> ```

I agree, regardless of the key, value of fd should be int.

> I'm not sure if max_entries can be a uint16_t too. I suspect this may
> well interfere with BPF_MAP_TYPE_PERF_EVENT_ARRAY and its use by
> bpf_perf_event_output. Probably best to keep things in the BPF code as
> they are and do your builtin-trace.c fix. Perhaps someone else can
> clean this up.

I'll do that since I'm responsible, and I'll based it on Thomas'
changes.

Thanks
Howard
> 
> Thanks,
> Ian
> 
> > > Therefore change to variable size back to 4 bytes for
> > > invocation of bpf_map__update_elem().
> > >
> > > Output after:
> > >  # ./perf test 100
> > >  100: perf trace BTF general tests         : Ok
> > >  #
> > >
> > > Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> > > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > ---
> > >  tools/perf/builtin-trace.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 092c5f6404ba..464c97a11852 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
> > >                  * CPU the bpf-output event's file descriptor.
> > >                  */
> > >                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
> > > +                       int mycpu = cpu.cpu;
> > > +
> > >                         bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> > > -                                       &cpu.cpu, sizeof(int),
> > > +                                       &mycpu, sizeof(int),
> >
> > nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
> > problems like the one this fix is fixing. And I'm blamed for the bad
> > code in:
> > 5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks for the fixes!
> > Ian
> >
> > >                                         xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
> > > -                                                      cpu.cpu, 0),
> > > +                                                      mycpu, 0),
> > >                                         sizeof(__u32), BPF_ANY);
> > >                 }
> > >         }
> > > --
> > > 2.48.1
> > >
> 
