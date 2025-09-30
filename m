Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499214D283
	for <linux-s390@vger.kernel.org>; Tue, 30 Sep 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252227; cv=none; b=sBCgEFySIVfb4CmEwCiLIATIw6aLbkmWNJlLIe4lDhQP21azwjS4+7C9ZMYHJnYk9PvJ6/FAPAGuEvnDH7XINQOfzsexIhkayB0iYzEm5IMp97Ef2k3pmiJYgj2RVs0rtTFXFxaR8DkoOxgw6WnTWtuEPWyQj3L3nx6JDPjy3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252227; c=relaxed/simple;
	bh=l/9vQOja52zWGr2SV6BFIwB/eAZdivVGNlNimJSrUyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT+AQDduJZtjamXZR3FjBlm/LzJuAOfDvPU9Y3HQ6uFfX2UTTTlwk5PfDEdX6bxvsJl6GJCNu8WmkdgU84zj0A8r+eH2COyMJWudPPcMMRuIJhenS/SXe4ffcvOJ++t/xVrHUsv4QWUNhk082WoijHdOfj5AIyRiEMlMMZIDAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFTLDP4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFTLDP4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759252224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bvZchW5POfl0SklzNLfUUgxWMzju251m1BlgdouOoU=;
	b=IFTLDP4/8Xno7baw4Y4bECP2meVt2TE9GNH5wZ+4495rYExuo6fzhCe9bqO1duJDn5mpKQ
	hqq3uyEfiiV6cKkiPhXUYHrOkKwRy/wrBDuPKZ7DYKO29LrkHuNfRbcsYi2TGkpbFLPBRJ
	b0xo52/Y0Uq8ljqxAgfVjvo1ykSy3Zw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-iAfcSDxNPhu0p84JolpdoA-1; Tue, 30 Sep 2025 13:10:22 -0400
X-MC-Unique: iAfcSDxNPhu0p84JolpdoA-1
X-Mimecast-MFC-AGG-ID: iAfcSDxNPhu0p84JolpdoA_1759252222
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so5737138f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 30 Sep 2025 10:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252222; x=1759857022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bvZchW5POfl0SklzNLfUUgxWMzju251m1BlgdouOoU=;
        b=r14EpSTSthagLPeIa8EjflMG2ZzbLY2NwZoDNUM9pxAJ/JuPm6daRXDZZ0uMIryLpn
         1C9uDhkFWjJg4PGDJN/7xXwVr2m0SV/jTDPCViwAzjS3g1HcZ9ClN/NPvSCaO6Ht7TlE
         I5Nt9r7wwM+fIGzo7R1VcXtwu3e4VfvsEQ6nyNZGV/+UPhuIZtdeoiD+lg6k3xTxKRW6
         aNAXiRSrSnZ3sVVGLRpogLDmDwflJMFjMai4Xkbj+EjRvZ37s/1mY/1sYTSqMW6YbQnt
         bGGN2ydgByQU2xUH73QJ8s/B85M9nCohwICFlv8mxPbFT4LEDeAyllpw8SemVAyu6HB2
         0glg==
X-Forwarded-Encrypted: i=1; AJvYcCWS9KjwEqDB9LEENmkp1VfApc+5oKgJGujU+1zD6uEAVTJgab25MZpU/NMB9FfEJU6V5pxzxTLJBDfb@vger.kernel.org
X-Gm-Message-State: AOJu0YzghFfmdRL4rkTNn8v0xYI+YroEedTrZdYF8efdcGiZfQqm5sQ2
	Jsl/Ci6KcVnafNIglRk1aEb2EMGcYG9yln7+cm8sApPY3GTlrmDYzy57JIYEA4dVBPwuLaWnyKP
	JAIOTqjLfzcQu5+LT1CqT1lnTSBX1PKfjmAiKGWooIBe/bIk/uH4Dam4rmG5KU+RaM0qB19vl8q
	IlUdpimWFQ6PWMTGfcl8tqLPbKIs1R5tReXxQk0Q==
X-Gm-Gg: ASbGncs2fr0JeJ55w48y4uQWNSz+kVvozTYbaY00gF8VhFZ7TGhnX8q37pA1XDXg/by
	NndiUNP6VAHZaW36xO2hjZb37n/upypaQraN0KBj+lPP84T0tPeck+hDgZJJrJiNX6KXQsc5paM
	GHUM2AadXeDlMBdsvwIgxjA0NcJw0iJ9sIXfw5Qk3JyBfYs7h1sjZ+1k4qbyhAU/vtEYpZXjadR
	FPEMd1hAg0CTRy+dX4tyswqESHaSMKn
X-Received: by 2002:a05:6000:2282:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-4255780b81dmr424401f8f.40.1759252221737;
        Tue, 30 Sep 2025 10:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbexHK/yhWIuTTvHWW5mhOLtn/qDAllptgnJWjFy6ytUWmpWCTjnevpMYv4ZPhPR3RAr9+DHFBsNcIQPLx4GE=
X-Received: by 2002:a05:6000:2282:b0:3ec:df2b:14ff with SMTP id
 ffacd0b85a97d-4255780b81dmr424381f8f.40.1759252221336; Tue, 30 Sep 2025
 10:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930163350.83377-1-imbrenda@linux.ibm.com>
In-Reply-To: <20250930163350.83377-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:10:09 +0200
X-Gm-Features: AS18NWBf5MK9iIP6571zd9JW4tv_B2VHrv4ecEs21NVitTR9bCVqN-UF9-XjQ4Q
Message-ID: <CABgObfacb9VhNXQkV6dNWy+E4JEShFhFnpuvJtW4qVNKWTEgmA@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/2] KVM: s390: A bugfix and a performance improvement
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:34=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Ciao Paolo,
>
> here is a small pull request that does two things:
>
> * Improve interrupt cpu for wakeup, change the heuristic to decide wich
>   vCPU to deliver a floating interrupt to.
> * Clear the pte when discarding a swapped page because of CMMA; this
>   bug was introduced in 6.16 when refactoring gmap code.
>
> Unfortunately Christian had pushed his patch on -next when it was still
> based on the previous release, and he wanted to keep the patch ID stable;
> the branch should nonetheless merge cleanly (I tested).

No problem, it merges cleanly and has no semantic conflicts so it's fine.

Pulled, tanks.

Paolo

>
>
> The following changes since commit 57d88f02eb4449d96dfee3af4b7cd4287998bd=
bd:
>
>   KVM: s390: Rework guest entry logic (2025-07-21 13:01:03 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.18-1
>
> for you to fetch changes up to 5deafa27d9ae040b75d392f60b12e300b42b4792:
>
>   KVM: s390: Fix to clear PTE when discarding a swapped page (2025-09-30 =
15:58:30 +0200)
>
> ----------------------------------------------------------------
> KVM: s390: A bugfix and a performance improvement
>
> * Improve interrupt cpu for wakeup, change the heuristic to decide wich
>   vCPU to deliver a floating interrupt to.
> * Clear the pte when discarding a swapped page because of CMMA; this
>   bug was introduced in 6.16 when refactoring gmap code.
>
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: improve interrupt cpu for wakeup
>
> Gautam Gala (1):
>       KVM: s390: Fix to clear PTE when discarding a swapped page
>
>  arch/s390/include/asm/kvm_host.h |  2 +-
>  arch/s390/include/asm/pgtable.h  | 22 ++++++++++++++++++++++
>  arch/s390/kvm/interrupt.c        | 20 +++++++++-----------
>  arch/s390/mm/gmap_helpers.c      | 12 +++++++++++-
>  arch/s390/mm/pgtable.c           | 23 +----------------------
>  5 files changed, 44 insertions(+), 35 deletions(-)
>

