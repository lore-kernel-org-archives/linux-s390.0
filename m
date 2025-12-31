Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B52F6193
	for <linux-s390@vger.kernel.org>; Wed, 31 Dec 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204575; cv=pass; b=kchEVMpZoJV36fKMavSCzoTjEtdvjGD5L+YpcfBFv9cSr74lU6Y/79QlBnDXEtqkknsftpRCKBUryKfSZyPTav9PwQLYuMYMrniwj1OgH4asvPwZSIRttOORWldqKmM4an5E/Hn3fpHmInwe21lWsSQXttGhI2vockCS8Z2vt5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204575; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFmC+kmRfjRP2VSApbEfmkYyuMlpKPXX+FLNMarqMaBCM0I6pgmyIR8X+Ve+l+fg9NrQ7np2X69F4W7CcEvnioyiIzJ8N8h8lyAmR93yawiYjWRGyPvgVcVpxtoTrZMIhupsoglM4z128wjoKembAFCpHHhDHZlxstwUE+7yNY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eMIZNaZx; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eMIZNaZx"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so446545a12.2
        for <linux-s390@vger.kernel.org>; Wed, 31 Dec 2025 10:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=kYgIr5k5ZpxmfgUt6f52y2AmnX3g5ONfNK8vrE54q1qYYxRzzf02Q+JLUFrfqZmGWS
         6cFIe+whJtpnulHnJlnZHufUAMMVvsAJTCX2hh9i4QQEW+7ddk7nxX8MBZp+PN5WXP5c
         3Ls40J8OOVAH0jH9dLuVNFkYgn08ULWHcH8IHjs5isJMr/7RjVXRwjlKlnxZaRYMRlyF
         palsa6NxijSm+sk6P8m+RnMhZ3AaIE1r70OofKiVc+bZHTOPF85YBkKrvvSIIvEvAfxr
         hDn5yOyIHb1irM0ITYS0WQKB88hcqfouWLV54xgkmI8PKf7rPqEUYneeLwqoFdetzwMI
         IGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=blGKWDrAK1D3roDdg0jAs0fOdtjeWsV+jYM4PrJsRgw=;
        b=V4jsu6KzagXEUUQS5w80RacxP5mDJ3/jDjwaW7bGeedqDae+X+L6+koIGE3IpZ7k8I
         laoMjUtH8hKgSfhDwyZyDLRtqfZQxl81bEHHxkryFZHsImn8Iwl93sr7RqXT7Lbuzj1N
         gYqcwVQE24dN1AfqtAYO1GtmRsVXDkIclFlTtZwi6o4WFnvLDQz6A5xhlIE9BuioCJPm
         3oJA2ZuJF611Rl1PqVLhoDhqm3FME9vWvg8gLc6Fygo9Wt4Rr0jtBcv4/Is65JMlZcFf
         8X1wcFrgpKhON+noxloympBcFy5ATsjxX4axz2Hm3qr1UUAkqlf90vdcoooRw5dpjYW2
         ofiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=eMIZNaZxBhjFWbRV5ha9XKWe6+Thr83KYVjbX2EkOS0ijkIS/ouyjp0CtYoTRWnilM
         e58ePoaklivu0fQntxNqGZw9WUotToDYHEVdITkDaRpzEbVk0cI4e+0WXxKdC9aGjZJj
         JgFBFp0fhc6aUWuQCuIWhwiQ4wMayISpnxgDrXkOgMY16odAXqHr9AANLOBFS7j+6a5F
         fJO0q61tAgcea0PhgKSTCegLBw7cy5T1i8LarrJq8r33fGcLXBobunY3aVGko+6xOKhS
         RkYLDJqwAvKBEaH/S64IIxntuSDjfWqmS+f7PwuwiOI+FcPy3dSnealEdllqritOeNLy
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=kHDwyqzd/Nv5awsjtG5ggu1KwYYN5aLgdoOetPBJdrNtMpS8ovhATmV+8+b8sf3uPB
         XfYvj8+xftMJkREu8sQbiIe8TnuMtOMx7VUafM2sehXuhb5D4U0gLKuGrFIAlarR/vJo
         VMBPXn/3qt9TLgXbUrfLCmJf3LsUe01F1o/xlDyYljslNy+SFJJ1AlAHS+KXiAyC/xLG
         cLCiOa74UD6mvkfG7vwH2EDym12U5VWFFXTxp9xSIwkjopLsbRsX7exuqYnAhG4DsaWj
         WieUpcaWZmfURc45Eyzxtoi5og+6NLSHxruT/bMuEEefxGqcAIp5Gn/tRdGVO/W5FXRT
         BUFw==
X-Forwarded-Encrypted: i=1; AJvYcCWrjB0Pn0oNNcqTO6R3Rxn+E+4wVxYrBKiZGT5+G9pGHwm+Xb+QAb51A8BPHfhViGTPmlUSZbCLGAbE@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNazPvbBkEglupJm9SFpQqXDO8UYpivseE+qkPwEu9UAjk5WM
	PBuKenTJqx1EFprInXV2o9QUqEqpFWQrAm7AacHp6hAmJ3bqEi6S27JLoSWupv0QJ7bd8POeyS5
	3qI9xhbE1dgZCsXqBGLQ9RO7KcHbmD8zGvXNMj5N2Dw==
X-Gm-Gg: AY/fxX5nijBM6M/iJ9cezuKHnOp/UdsFFVgPbgWJK7WYgC7AX7i7bdLK8NRFHpEah74
	R26t79pEep2XgHy+O7EIEu+GHJErk1sdlTOcTfC+d4iD1JmS918nSzxT0s1P/vWYZmzmKc5m0UL
	MEH+GZOh5xYaFiMdb7gaXsDFaObXOWKERDAkqhdaLdQjflUBtyWaYSsf8+nqu7oiReYNqc5ItP5
	gRAUm2qnMxIlstdUNHnIdwYT5M4TJURMCVK0y5SYtyQo5Y9X1bL5Q1THW/GuEiJ8Cyt9zqBhWGT
	tFbRceY=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229
