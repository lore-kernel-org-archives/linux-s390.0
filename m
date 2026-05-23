Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5AE322C67
	for <linux-s390@vger.kernel.org>; Sat, 23 May 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523482; cv=pass; b=CoCgxuakqu+WYfjTVgx2mo72LGsPxs63eE/ZS/BCIQbVua91gYBZrvp3B73gMFGOtWU8e0X6IHXIkqzI7g94bWXrCAa+H7/kiV8/edZTsAFzBCo3f1XQyHOpbvVQUIceDJ66jNG5e73iUm92BhRctvHb6UJCPUiBeSIRYMMuePg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523482; c=relaxed/simple;
	bh=K7Vnv9KOQb+dC4E4MeSvCa6bjIyrn4+Roa18WXG38yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGJ5wTlA9haaM7Ibb2btlj0KrCRuSxGTLND5s0N48zQAuFz5m5qFRmwHE2FY7XzM5L9WW4SCX6SpHwrE0YiAJCVAYzsOzpFC4oYUJp4X3bDZ+a7R3xk9RGIrwbbj3TDYjkCfk6dR1PKOObwdVfJeYl5nRiaf8hMo3KjTpkwzVq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/MicUfg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/uFCpRB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/MicUfg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/uFCpRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
	b=V/MicUfgQjkZFEYzbNx3Nck47tizneo7pxRsm5dgzv56CyUr1VXi4PBkiOYehpC8v4kqJI
	sLtnUm8wQoeN6/zYolD/3dsU/AyCiJDKLelzUv/+sjaCvHP2X0VeUW+G+U6gKoCvfLbZlJ
	Q0FBemug1LdvjnG4ftaBza8l1g9kk1E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-7snDJ3zROVqUHexmarUD2w-1; Sat, 23 May 2026 04:04:37 -0400
X-MC-Unique: 7snDJ3zROVqUHexmarUD2w-1
X-Mimecast-MFC-AGG-ID: 7snDJ3zROVqUHexmarUD2w_1779523476
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e80183514so5545736f8f.3
        for <linux-s390@vger.kernel.org>; Sat, 23 May 2026 01:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779523476; cv=none;
        d=google.com; s=arc-20240605;
        b=krqIF8o8d47WjUBD6Pm0HlZWE0cf1g0Vmgd1GVOQctmiyTqNW0y3lkBnbZ4rQUdzPc
         LoF/z2MUK4ZQingrD3DPbD3TIuMdJelDi6MlGWBqag6p9x7IwmL21U7ZT5YrKmjucAiY
         Xid3qaewfk5h9h67kyu7sPwGoqlQG0tzi9Q3nST1/BqLbL0g3f5f9Wq1e/x27Hg1hwbj
         6Trdzgf8WHdNhxiMlpYVGC3uc72FtiaY/sxp95+lPatJZFpSuxmRd3lY/iUXCFh1DLNd
         IMeyzUriTWJIyhEnOOeEt4cvN+BY/vG1j3DbORIEmvQVmEkc2lGTeJP+SE2irXQxShgd
         sXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        fh=tT5TJtzXBaLBHNLaqDu063VcMlNLvUt5IEiC0h/B1ZU=;
        b=BS2JMIrDq2eRHtWOzhjYQHMukna08xbsBFducgSfgZ76KwxZNDYXQ5AHNh9b7ui21J
         LmjQ5YkmBBaL8wvp/h0GLNi+rX2pZGA4hsHqJNj6shc5UDW1X6FdyRuZASPLHDAAiSQr
         pHZ2YFynB6NoHp0ZhOG8FcDNcZx5KpeyRBPBkDTWVSIK3K/itzO0iMTOmiA93pXUEAZH
         c2HRjKmxxkFev+RdZIkULVu/n/rgkNUx7rB+O9wwrtEtFzDVni7Hgw4W6fPuLZYGeR1a
         +wH7g9nps7bvR30mljx944fIjkkHFgm9jUfGrddBIvC5jGIWWOFtwv/7SQ+wygZ8FBCH
         1EtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523476; x=1780128276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        b=e/uFCpRBLXUQX0h7iJptCkRb/WzsuI6fn885SoFvyQalh+/VQ0TTDHIc1+CX++lixq
         kPnU6ASxxDHF8pUsqxr6LmUy8XhkXtwClcGe1SykatiJSktvajF6HM8J0FmYhUNQQfVA
         LETeN13SvueEEvaNGmTX0kY0muPeWrCQM2dUpm8ETWHj41CCCL48cOUES1UKOdyw5mo1
         5dyYDzL9MA0//SGuH+P4+UpdfeN9AyKbkcpTnzZdLmaaJLwiZjBj8FJKiShzTXjRxIe+
         Sb1cqaC2IaNehpKXSAwLd9XwBnPzDKqrJtx0y2m+T2B7hoNcIbd4g3Rpi/TVr1JyaYfP
         nyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523476; x=1780128276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttamByqpUXp8gDJ2jEtCsLRWhVllrayfTGFh49yK7cw=;
        b=IizE+gTu4svgSvuvu3FTsU8QzlFDyh/UgMTIybaXqEWOSN1y4MECwwGOIXCjoulUNb
         NDguBvaBMqLHAPHugeuD3RIiEtiUAgqj1g+sq0kCOidolEn3p5CjXhIUh+D5lvsC54O4
         iIv9uYXjLrBsRB97PEtQ00P5wW2irAGMWheMEWJxUzy1y39t6SY45OJ28uOIXLys4gRC
         cCSaFaHjBn8RxRH0ul9yf6aP8qp2oAu630U5Kq3BdCxqMpqsMYGQPlNt+Scz/8p/q+ba
         HLwCcBlnm3v70cXEMdTMjmtdLNmITcGy+e0O07Z1BJpw+X609l8rYDUTt5XxT0JOn1XO
         oyqw==
X-Forwarded-Encrypted: i=1; AFNElJ9FvM7O5s1Pz0+YDHGDFTcKwxIzhkIQHPqQBHbJOZtv/zlnQmWdkxkU+c7yEnUBzD73yO30MCE6VOXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1vEJ1tzRzZmUSuDGjgr3uFKrzlpwx+LWnTpnweTlIw0yG8M+
	bUQ9AQy0GFpt11NzfemeNZGJOI0FFugCvC80LKgKBzL4ML6jX6Lz+T4Zi4T3QBmNWn0LQnKzI/9
	ZrTXF5YYY8UCqC7INNT0zOwzWLdpidonOh+kV8CKq6cDPnCgv/jLDPgG5ytgn7MNdyUGl/dIcHX
	N8EqU0YMxjfl1cubFUMOyr7ZdPhmzRSss3HubWdA==
X-Gm-Gg: Acq92OG/w8cx5UJYG0EiGYRDvraNYdv3iriNZFVwAxSDBG2jJotZSjHJsV4/ovrNsMH
	lWvNNaN+8w//8VAY1Hfh9ChXl8ZDc5Myexyb27hxJcMmOmvNyvLYJ6WELKWlNq/WAYPecLh6QbI
	OpThXN8bGAxsOanVtzT4GeLN7nZ/Mdf8izvsqJmZwwripW2iNGMhnazv3yWN4IUk6inrdNT8oR4
	fm5r9zfvnMm+5xATsLHGszE5z0s5UqSRSPxLKe7iSuXoAb+foM71DAlIm+vkaFsa65TCGpk6pdS
	MuyY/WQ=
X-Received: by 2002:a05:6000:1888:b0:45e:73a5:e5e4 with SMTP id ffacd0b85a97d-45eb38b9243mr10583129f8f.33.1779523476051;
        Sat, 23 May 2026 01:04:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:45e:73a5:e5e4 with SMTP id
 ffacd0b85a97d-45eb38b9243mr10583059f8f.33.1779523475505; Sat, 23 May 2026
 01:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 23 May 2026 10:04:23 +0200
X-Gm-Features: AVHnY4JHAW_gQrvPAHWDAel_biT7NF7yn9kNkYJxpwYTRO3g49bL9AydaXkpZHE
Message-ID: <CABgObfZ9sZ=BhOMVWNO8pg5JjQmZ6=PNo8dEv7O5VfhrT=LzPA@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/5] KVM: s390: some vSIE and UCONTROL fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 2:30=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> please pull this small, but important, bunch of fixes for vSIE, still a
> fallout from the gmap rewrite.
>
> Claudio Imbrenda (5):
>   KVM: s390: vsie: Fix memory leak when unshadowing
>   KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
>   KVM: s390: vsie: Fix unshadowing logic
>   KVM: s390: vsie: Fix redundant rmap entries
>   KVM: s390: Properly reset zero bit in PGSTE
>
>  arch/s390/kvm/dat.c     |  1 +
>  arch/s390/kvm/dat.h     |  3 +-
>  arch/s390/kvm/gaccess.c |  1 +
>  arch/s390/kvm/gmap.c    | 18 +++++++-----
>  arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 73 insertions(+), 11 deletions(-)
>
> --
> 2.54.0
>
> The following changes since commit 6779b50faa562e6cca1aa6a4649a4d764c6c7e=
28:
>
>   Merge tag 'pci-v7.1-fixes-2' of git://git.kernel.org/pub/scm/linux/kern=
el/git/pci/pci (2026-05-21 15:02:12 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-7.1-2
>
> for you to fetch changes up to 9029496abfae3c208336855ae6f3e1f5f881ef76:
>
>   KVM: s390: Properly reset zero bit in PGSTE (2026-05-22 11:25:11 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: some vSIE and UCONTROL fixes
>
> Fix some memory issues and some hangs in vSIE.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (5):
>       KVM: s390: vsie: Fix memory leak when unshadowing
>       KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
>       KVM: s390: vsie: Fix unshadowing logic
>       KVM: s390: vsie: Fix redundant rmap entries
>       KVM: s390: Properly reset zero bit in PGSTE
>
>  arch/s390/kvm/dat.c     |  1 +
>  arch/s390/kvm/dat.h     |  3 ++-
>  arch/s390/kvm/gaccess.c |  1 +
>  arch/s390/kvm/gmap.c    | 18 +++++++++------
>  arch/s390/kvm/gmap.h    | 61 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  5 files changed, 73 insertions(+), 11 deletions(-)
>

