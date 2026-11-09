Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263409;
	b=VBHyUQzifJvzNjZRh5aOsDkHGUzUNHTQ03pncIFExgz2ExF8RinLdX2PZapJOlb/i40c
	 THPaBE8GWa3QZFcA3wnW6HgHrJQqiuLdJKbyg+55JGaEV3FQjYWqDPxjz6FmYTOWVGNjK
	 b9XA1bdkKUoexytnD4Tt1DQhmmeE0FvB1wd6hkL5g6Sn57HwpxEoie5GjwXtD0xHwGUHf
	 G56OYeis6Sq3kG+MJCaAWDiwkF5XRWYdlgoMho882R5polm8KAk/C5vEVVVhit3/6+T/g
	 6CrozIu3tLVKH2XiV3ln0Alv05CBrN3OlUqORLroRpLNS8ea+2sbSNd9kiPrAqt5zVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=y7Peb1Jm9k+M4OZF3Lk6sz1iQMAmV3aAUYntWgv9WQGHKi3YXoi2XCUsmfPRLTYgdENT
	 l+eVWpPu3zOALp/Am7J94M+5eP22rg5n9VR23PqamPXxipN+LkgGUNAZiqTdfhXOddI1U
	 HDplTe1C6sShygKpAmkc6Ye3+ltof3A94Nh3DnUS84ffg82V0d1x4GdMKCmDzh7GCabmN
	 IdDJHLtSAJunNwguQezEh/b1aKKtlB9k2Ic62pkW8LHqS8T4GWmoZWy/APALhvQG0RPfx
	 c/9TZdTzbdCDOpvunD04q7I3+9rwVPWhRHropv6YcyCuOLdtHKxPChWMPmwECdeiLFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3D606A330
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D3D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-535f598d126so39521cf.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=JQUMNDq2iZouzPNeBaKSvlU/QCfxzXitJvdun3rR3qVhVlx5DKAKSmi1d+4JSob1aG
         hKFuUcncKVXBcrD/iECfX+xw7Xl1R3HlUHKDnuio7UJ+4QKXa9mvTWoojnjTbzyfIBJl
         VVMkMarfiD/JyFbxEtffoX8ThlD+D4vpFBE5urn9smF6F6E91JZe/7ULirIhgyMqNZLu
         6pZsQkF2ODboyNUn7QEb6cWYhpFQGrHUNkBBOeb1vqWWHjspscrVGD0A2y7w2iKPeCgM
         9TqQJltJsK+QZjdYCMRBSDm+uZfrZei9sdFwrRS1DdHRDDEz7C+AtXQcT747tL09aear
         tyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=6KqeYMBGVP5rPv7IUPN1x+nf2NpSR31Itbb6A1nHKwA=;
        b=qT7yNe6PXpHD/mt/UUR4AQwusrhpyK/OLbG/f+kLk6sAZSAtawlLXkU6BjHM1/n2+U
         T5oXKP6UWkpqTLhsU3IxxA1FXtSe8sk8pU0oGESdkLca898QpDXE2i43ucPE3dVZNxQy
         mN+ZToShuczylITtGXxIpxJ8BowJlXoPlxvrm3VHyV07DDyHE7SEBrF6Ul6DwQJiQFMq
         vecjYG6j2+x84ArMD8E+5fLfG99DNFA6mEsz9BOLDSRBuGsbBFkp0PgNDXvepU+vnFqX
         CZedslmhSVOl30tc1Zp75+yN7cNBZZa5WUr+1OsCQWzBQ5r8Z6HN6NsiW0NFWOB/Bfsg
         h0aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=t1LWiuwA2QABzfwjiruVLfY/0ImqkgD3IOkNEapqLZ13YeOXOVev/kWvx1hFNuoB3P
         7C8HUOu2Mcp/6pdLB/EAgpUOEucL69mV7bydMDAYycerQth7SF5EtALszNNj6xeV5d5u
         riIEPOrN66ZfR+hHIAVPaLEaXYfa65fmUS+hhXryWa0FrmC8p1d1xYfgCbQ47QnCgWeg
         //uz4c7yBS0xlnIC36AySR7rWUtVkxNAX2TawDo0DIHrHlwG7TYvvtoSZ5vjgSY+Cw9J
         /2RcR9OHMfSc2GXzs0heMondQmqDMl+C+tegUhNGsX0KdTulRNEoetwiVM9NO8XvGcSO
         OCow==
X-Forwarded-Encrypted: i=1; AL+hErHumLTT0DQOtfSe6OfaA5CZo2Aj0eNypZPOtMy/rT3dzH7nnATis5/G8oh5eZfr9vUvAF9PCzbdYSQK@vger.kernel.org
X-Gm-Message-State: APuU4Z8ovBce9S8oLt/SbnhRji1S8AzwtihhURLYBEhWtAPOEe+1zmuu
	oAkcaiBkLkFBOMQ/A9LNaVmWtK5FYqhwP9Dj7LGIJRGL57Nn5dz2YSx7fEttUc6gaX9cmLRkuvp
	h1dU7kNpn+waw53ZFHQ3/SnfGDR3KzarBLdlat+3f
X-Gm-Gg: AYBFou10CyvGpS4inOhWHvGCVyBz5i9RmA6wjscS+RktNWYWuFJTpEcUuf5bWzNK301
	UpILO/+V/4wj8cJhbKnJuHBTohGxAOV54OYbOBuUaNkdCsCjKrc6KfVlSEVtmf06H1smS2Q12J1
	5D6J2jxM/UAQu60cjMdVwqRSTImecJNRYkFaeeiQtyT4lrFldSzVhaY2cvTZt74hyzSwH77m4pO
	eAFui7DuU2GDfXb4uBw4hXQcKfZsTaUX/ReyKqwtaI0rOuDr70PGNElGWgMgmnTOcCqUWCWqysW
	EvimqPu5iOI6ayfSWD/TSndzXzuVZ/R0lzZCuG/ls2BHXiOMeSeO2RBDbq7spfhEWscS3aD1ywz
	Apoif8kv8Q79oLEaGcqH/w7j7ubK9soEsbJWBKBpIayHI77G++HZgKzgmPlzP8nlFyhQ=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
