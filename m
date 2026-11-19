Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067160;
	b=EFwMg0Khgad+CLoLasxxQ+olaH9bcY+2lyy2jMbTRBdEYJlP3RmWxkWNQoPv5BLmRa/Y
	 TK/S6paLsi6RWo+IfJ8oxmYFUakliRDe5tMmOiGWNq6F6keyMhWTJE743JYXWpNd/174/
	 EFKY5k4PJA2cxij9ICgalQQHVS7BlMNVrEsTNc88mT5ShzvYzbPZFjwIFJ0/qbPQkRVm5
	 JgOMafvEbA7+orPMDv+RMljVOxr4JKYFsXrhGtHtf9EdNEWKT8a7m40VUMO4kqKn11Mn+
	 46n0ZdumXiGN7ZX9aRxJZE8BEdZEfXkK/dT3B3FgCyQk+VrdUN4gY7UGnqu6lFOXMpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=A6Qwwlep7hMwWD/6wZYXSYPSA0PAuHcIrTAPhQ7+SDAYnVafJa7mW0yFvF84MNq33wzf
	 e/FkpLCELgrpEp/DhGfF4toxalonr7NHeqkU4eD0t7IIbjcJlrta7A1vAY3AsVq/q1uez
	 w0wzhL9i5qMmiMFxW3k1aabdm+S84OkiGZjdIY8VzESTsrlHf/YtSgXS+sZ78gW5XGlMH
	 SXQY9LzHaJZB+4/uCGDJyyqLubyES/ldltWWtNocN4Zc6IR9yE3HxrEg4efIwp7MAEXd2
	 k96XpIx+CilA1fJg/7qIPHLj3TU4khNfI9mVV8V3N5FDWJjclWOymBwOZAH1oyKyWVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E6606A333
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168E6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55be673e029so117441cf.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=hgUVkpI6YdSwO6G6iqhd0/jtXnr8hCmdXI4GjDYfz+LwE8ZQ7/IpN2lTlb9QCYnAtZ
         mR2z6lTEtyCsUfMWprSa00h+Hs+Ud+bE+UQBHcHcv2eCSYRGVBWr047U9dmmMohwPoc8
         E6KhckEtCrnE2XaHenesuLLEfhDl7tc5Z+14rOt9Tt8gZhQif9d8gL0EHYmZB4OLUyRH
         BRo1p6pS1zrgz+y0mJz/SA7mmiPpIxqE5CBFOu8xyDUr78TU0+Q1EInyDcg/ixAWrGFg
         /tfanjFJ1VI5mHuOwb2f7HAgupyvIqE+LsLqzMH479aH+CrNwMf2DvcWi2BcLtkSD8fu
         vOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=v5Sc+thvNCHhJWK3ZmpqME4IklM3dTZQXW7epkmhxK0=;
        b=qxAMvb/iFQix+NUrBfj01NrEq7T10WEt8T4s62zzDywvAQVLcuHf97dLvuhoTqcJpE
         zQJORdtBv7OUYo6j21/x/Wzhpjf/WgQcZmdLxB460BcuKigcTAroBbB+2algajaPJYUR
         N2IGMgUfwstYTdywsZOeP0ywho6NsEXPs6ZkFta01SQhSfKVtpZgI6+qRGHnVcI9og1a
         o33tj505BV63T8j00nWool5RxIxasjCwvTLj7iWotNFELktD1NHPBTxRqqphBgJaYnir
         kG7T67s7xNNLnl7l9P16DwtMuy0sJ9FgOBF/eKDI1soVPcj/W9HMMKV9c1LblKeIB1I/
         MzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=FmkGftyacxPVvf4u88fuIpT0ZdPjNDPd50zMSWgGKHTH75skRyxAqRgdLqtOIsAMzU
         FyMTtHuSiyOKM5qzlLmu9bpJvr4R5oq92xCr8Qy4CtsNVNKOzlHxJ/EJPluY3ZT2rzgy
         BgWgB9qQldeNRqRA6aMQy5O1Agocy1c78avaRYuKyoHKpJbSBvdisw/AGDrgtVBM53mf
         FQ+0bmM32c9jsEh8oNXXxcZP3ysJUci9mR+DhJKTE3CUu30K1yB93hweXSoc1e4q8M34
         rkEN1ugstUJPUqOr1w4K6di7NsbCp1J7ACirdrw+qpARCVPz/8jbsPzflJAnngiCa96J
         Ruug==
X-Forwarded-Encrypted: i=1; AL+hErGOuJ6z8kEBoKvckMKBvmFkIvN9fDrB+JYBG5feJF+RdfCECjun/oxdTtReaIpX/50BvBZlWbHGXuPY@vger.kernel.org
X-Gm-Message-State: APuU4Z8MoPOce52qPH4TAu6+zfGuo31PRi8gC8B5QrQ5DAJl0YHablB7
	35qMBgLHxr5DQdKtKPkJyKDVAgD3M/br6G9W8d1hjL/W9n6cnf9Vp5NK+olY7WyfEUlcVk9KBSE
	Wku6vccS3ym46YtFX4DfE26viVcuaog/BgXyl0GeU
X-Gm-Gg: AYBFou0eJ83gSkWxi1M4yeaiUVuSbk0G2YbFY05TgC5D9Xf0IJaHTGN6AySRHaIuTm0
	b+u2IJJYmxdJLg9IYfTSMcGRfmvD2qfdLAoKd6YgPhcZtOtudejcOdk7xf3qOmsO4AKKu2YQlhw
	p8LpO9ATJn9fYkr6x+so8TSuYEyPhl/8qZSukNZNdiUoZcT2DIIsTv8Z+uXpbZavF+1WPVXpHVj
	dSwmQ8troGKMOH73OOAqR9AibNisFC4QnAvUcY5BB4g8wZxqL0rzy3a6xkFDEHa7oBdeokeBEO+
	Vf+s4B99q5hSrzYyly6FcuNkV2aLdQF6g64inT8NDvNfhZrhrlOaXlrbuyfB/R2oy8jlbSsYDXs
	g1dC+2wMaxp17TY3Ff9v8EgYT0wT/j06+BOYA
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
