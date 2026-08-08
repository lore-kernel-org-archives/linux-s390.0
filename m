Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260253A6F1B
	for <linux-s390@vger.kernel.org>; Sat,  8 Aug 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162437; cv=pass; b=KtVN57TxNjMnQz8BYq72eXazDUzhq0VVaHp7kHIQLajGADF6Cnpnaj5UovIRqmNIOMUhlX208kscCaxDpvTNnI4BIhLuYSW6KEM1aY+RGFCvs/oXO73d1wKoMYSGjZDa0axo3pSYDriNDcXdzo7/tf0WnPI+qiOQ2ZQuwjJWT3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162437; c=relaxed/simple;
	bh=aitTYh0qnUbeJYOzgNmzBLyVNMmg1720VEJ6UqV5Rb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kntk6Ic5vzdBuYBSX/kc3JtR8tQIufzkIXNaQ5/rFvNxN4veEXISGB9Gqtd8jlBcCiAisd7uw8yr01ejpPAOkTV0G9Zen/Enf+7t+kERn++/HInkDDmZNu+fzzk1XlUXaJUu7omrK3ESyaImb4L+GkbS0EbDto4OBbd0Qf41jFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5Kzoowh; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5Kzoowh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c15a5b265so116171cf.0
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 21:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786162434; cv=none;
        d=google.com; s=arc-20260327;
        b=aUI/j2Z0Ns6NiivSk4GQwZNLLdTiIpTU7CthVWOGhjy3gRo/JHRPifHfAZHTSVGgBY
         kGmiPpMPIHLSyiRM3pL5YtdeLqMZXp3naiAoiYd17U9lJV1EGBI8A7UWepnPhve5TWIv
         TmXo7dOpguBJSmo9gv7yRt42uQBHE8ehmGAtqptgjh1+LPL1oVOcyGzB8P9QF/f+bo1c
         zfMdfuq4UM6ik2DGhQbcihSxdql7E1IgNDUUEu0qtL+fSHtttd3uFS/OBCGDc6oIMoHS
         mLB7TldYGReAUPBHfhSgqW8yYN00dj4dPorCE+6GjMOP6Oud/YGJE5w1uR53O0UZnAoE
         Wwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        fh=NzrLsS+XHi0uvffDbthvOEipwA7PLK91KuBNSVU/s6s=;
        b=dE/fU4gMX88GgLI1N8r4bHKfSXJQ6mF/5hrEXJSLrrUiBpYNwXWY6Zv8ZIBZdL1Wy5
         flLcXwZ5OApHJGaxlvAExHAluW7EytZ+VUSYtnx6g3juIqiBIlpFLNJilaHN2/7cQ8Et
         bL/KvSm8jtevBrp4nvF9Pj6SRjsSUYVeOfFIGhetL1s0E93fUZAFOVNkvshbzVFS+XPu
         666tNAcbSTXaU2vlZORnSr49cix3DU/Qe9zLWISwJZpikAt7XkfJ+lnqnCAWZ1nCU3KD
         vJr9VwaJoqN6YprrZd3f1NOHJrSwxmtg5q6/HbL+d1YgNuk08scPSG/8LbW41PXmGlml
         sQRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786162434; x=1786767234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        b=b5Kzoowhlgqwf21M3r7LghuDOP8n3t8kv79Oy6GnxdlRg8yRAxsLCO4clquC+XEoXe
         rlHnt9s9e9pGVAeiBnepN4Dqp2MPtBB4OsyvoBAB/aDuAjY6I9Q4N2CBZYAO3pvgmIy9
         B6xdWxGOFlfleYh+5oIqXGiWRgJzDlsHCTSq/z6kfVYl1AG8bxXVWgwyi2iVu1qweEDv
         qDOPbFU18j4dJvzxUhOqzDtQj1ghA8a4GpY+uDVFlOpHnzllfXTNS6XCzeTDRZf9ZV07
         w+9vZ8WX0BHD+XVWW5B/OMnaLh1QDMub+3H8yPfronCdJUiitoTJRBDs+bMLtGRy7v9r
         w44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786162434; x=1786767234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4UK+N1D7eZ3gh+QYJXokrWxjuw5VKrcGy+f6JcSXuM=;
        b=Vps0A4SDuFPqzpmhm9J2Yyvlx35FK9qynGm0KP2R5ffH0NErMhm1P3M7RA2O5Qi7/0
         jglC4mC0l2cNL3/JO+rN06dhR1r65D8zOm3Cn9Yw9ESyUR7MRUHu1vJSaXzolehxQ1uC
         5I3nlRRu5F9Co3ou/6AWSPHBvLzoTpqKgqkIpy4eu48vQVr0no7ZQNPxOHotvBdMSzJL
         Pl6rJrCgz12nfIXdqHv27vl86M9M8mwt2U2OR2fgP2YUjTXwre0hkGF7+1QKVmajPri4
         RhTXIbY8dPDba+5LGah9Sy9pV9LXwg49bb5XoJyQHBG5/buIYVMDDYgSSwoIapvZySjY
         LYPA==
X-Forwarded-Encrypted: i=1; AHgh+RpOYLp9+CR65qYrkktwMlaNhQh1l5sUTVdTTYgxa0q1Z0kGnj3gb7i17Qk/ba1caM5buM3BmNfrmGhB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/r/HWXFOPqDEfqZi8ANhP9ZkB5WIWKFnpfp8c/G3kMj4d5KV
	Q+ZWk2gUKKbHXyjvcSOL1ZdSK/5VxxWkxJR669sLTdERykXkP58KVvKSgL0ujKaboizKbIFexoi
	MRIp8qiHVgwD2ZUma8BBxIFBZwQR3LRW0yulemDWX
X-Gm-Gg: AR+sD101OwZeJkxN49kgZVul6chQrbeDftFjrs5c663VmNrFSzcAur2QYq4UeKF9Bnr
	3dmMmHwxg4dmPrx7ytGuhm0YSjmeJDEUiybbM8YA15RDhb1tLoUepaSz8QVMIagvszXJCizhcRL
	zl4i3nVOMs+2rIYAHu6J6mbTL9ZRaEhOuwnm/gyn9U5/jaqV9ORgLumHIpSVHZBmh046m15V6e1
	V/tAERfQukrm93426EVL94pU8y/fst7vJr9kVTe8ktfB+6/Uod5FGlvr1QEvG2rAsdieZ6U58J5
	uufYCsF6uqqUFx+49pcD2QP4cyj5wUtPWkBURIJGOfjMEg==
X-Received: by 2002:a05:622a:d0d:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52d28158dbdmr3544431cf.9.1786162433527; Fri, 07 Aug 2026
 21:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
In-Reply-To: <20260807104913.1784943-1-jremus@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Aug 2026 21:13:41 -0700
X-Gm-Features: AUfX_mxDRuh5UGGtsR2bBKFmY2D2g9rp3fFigNKa7QRRZfcyrxDIcOjJPNv2T3c
Message-ID: <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for s390
To: Jens Remus <jremus@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:49=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> wr=
ote:
>
> On s390 the kernel uses s390 back chain instead of frame pointers for
> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
> USER_STACKTRACE support").  This is because frame pointers on s390
> cannot be used for stack tracing. [1]
>
> This requires user space to maintain a s390 back chain.  For instance
> user space to be built with compiler option '-mbackchain' (instead of
> '-fno-omit-frame-pointer' used on other architectures, which should
> better not be used on s390 [1]).
>
> Only few distributions and users built user space with '-mbackchain'.
> Therefore '--call-graph fp' may not produce the expected results.
>
> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
> added a warning for s390 that wrongly claimed that "Framepointer
> unwinding lacks kernel support".  Change the warning to hint at using
> '--call-graph dwarf' if user space does not maintain a s390 back chain.
>
> Note that '--call-graph fp' may also be useful for other applications,
> such as OpenJDK maintaining a s390 back chain (does not require JVM
> option '-XX:+PreserveFramePointer' on s390):
>
>   $ perf record --call-graph fp ... -- \
>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>
> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>
> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  tools/perf/util/evsel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ea9fa04429f0..c4d67d1b35f3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evsel =
*evsel, const struct record_o
>
>         if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
>                 pr_warning_once(
> -                       "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> +                       "Use '--call-graph dwarf' if user space does not =
maintain a s390 back chain "
> +                       "(e.g. is not built with '-mbackchain').\n");

Thanks Jens. The text was based on:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/s390/kernel/perf_cpum_sf.c#n853
```
static int cpumsf_pmu_event_init(struct perf_event *event)
...
 /* No support for callchain, stacks and registers */
if (has_branch_stack(event) || is_callchain_event(event))
return -EOPNOTSUPP;
```
The backchain option is never tested by perf or apparently in the
kernel, but this warning is supposed to pre-warn about "not supported"
being returned when frame pointer unwinding is requested. Of course,
lacking an s390 I've never tested this. I can imagine the warning
being overly broad, but my understanding is cpum_sf is the only PMU
capable of sampling on s390.

Perhaps what is needed is additional text after the "Use '--call-graph
dwarf'". The existing initial text at least appears to match the
kernel code. I'm not clear how the lack of back chains would be
reported as an error code, and this could introduce confusion as we
have lots of stack, chain and branch related terms in the perf
codebase.

Thanks,
Ian

>         }
>
>         evsel__set_sample_bit(evsel, CALLCHAIN);
>
> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
> --
> 2.53.0
>
