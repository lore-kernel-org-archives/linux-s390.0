Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633491;
	b=PNOngEW6Jybnmc/XX7sD73EUpnoh5KTcWdN39WIvrQH67S4kwjfGyj1FBTJD14TlYjnF
	 +nVbpitZhUNb7jRnHUcsOYCNUp7BCOGmvhdNlPoX2Y3WRHf+nYp/hD8PxNjQNNosGhu2a
	 TVdpGARiXPqTJ+uyCNYVIftDW4JJSKOzAoosMfrBE7ezCsblSvene/AZBqXIiVdN7HzMT
	 3SpLzYwpExSYkC7g8v2dJpcRA45jqembv9Ec/vAZvHFGCeZ6OV+mZYUCzNaqoV+TSB25P
	 DFsoqd+Vgx0vQUZljuxe2+pHpltILec76BlQ9FswWWWEKLzbK/0s1acA9Czzg7aTt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
	b=rlJUhdNjZC+ohISUbhTbLNqCY4SdAuntGgCU2eaEMxGDqkStl7ZnsKw7RvscV4aEhvJY
	 +AQnbaqFIabV3DKrSfHfHeXBnreh2XwuFbdWPdzuRH1MZWZXDIMOGSTbqYQq37BFQ+E/i
	 9Ox7HGMNy+q7zhttHY4ZpC8NbPM1e/Z8sazfH1aF6fBCyj8DhpskyqHQ4QOpTs7FVZI8X
	 kwzHYqlVpi1y3vfUG/QHw/gB4jRbw1Ifuk7ulMi2EMSblwfArYWTP+cDyhcZLv5udaLf8
	 dz9AioT4F4UOnOocaXmO3s3EUsR98HrV/Gc7+l0EXGvfN3LxJDtK15Bv4UBLyT+FvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nl7hY7qt;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC86072234
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BC86072234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nl7hY7qt
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so2553346a91.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2026 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633490; x=1794238290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
        b=Nl7hY7qtUztBhR/ooRIbWQrpDZI/7LILqgN2jjYhmkN3vQXLtzeLV4vEMKt94sHvKV
         PK/QHGLZu2w+eBthbWQB50Z4/APFytDDHvtopEIAPq7ULoH08xM7FtCHvqcuqIs2u7SW
         Y8jpOMQ3XojwhK2WuR6Du+deA9fXL+9TM4AEe0VD+f5VzpbAsYlnODdaVRUU0CpGTCZ0
         P7JWfjXujnz/UDl31W0DlBylHteLD0uz9hyOw21rLARZIKGFHJ03bRUkP5NOXR7x47ZG
         f6pWfc5F61E9/QzeY2Y7ufsIK4g0NXR9X11nHQOdAm5ybpoJa52pxwQffWB8d86GeFXO
         GpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633490; x=1794238290;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
        b=yEJ/BWc7EK2HRV626TWIvQEZyUk2vMjbG44gHyq6rCx4X/C5aqI+joX14AMN2rA7GJ
         Fp8513Ykq4BERWg5FDm2+FV08LhHjvPRA2wPtncVkDvTGCUHeBKXglHLBQupG8W8adRS
         PAcEezsvUxljs9s8rG8j+fIYSLKna1UZeVXWvOJJxoFwvEg39Web98yO+380KQH4wQB2
         CfVdixIw8dmgO8hRzTTIYRWANemEHZ3KjJuO1h3DeJXja/5n+UA3sJViU16pjaELS+Tw
         eygRUrzEeRGSTV1frTRz1U88BsGFWtzeUq1qYFV4gThA1DakwxqItB1n+IoMQB0jTuLA
         n1RQ==
X-Forwarded-Encrypted: i=1; AKwUvByTMheSBSXiB/5V0/B+yj2ael99MLN9h7pD9IRdir3+I+mJO0maFP/U5Teg+kKqAhPkcDbr3NP9NsbG@vger.kernel.org
X-Gm-Message-State: APuU4Z+D84I6r/Ut101Ftr0pci7rc4lCQzQ2ee2rrbqGpsCAZELo13sa
	Bea5WQOU7NpdGMR3l0lJzKvWQ38k0r/ubn4EIrGrhlBue8Qa0zloaSWxCHucDNJLH3KGNJFPOn1
	p7NRlXQ==
X-Received: from pjbgo15.prod.google.com ([2002:a17:90b:3cf:b0:3b0:7a3d:ca4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33ce:b0:3ac:ffb8:1809
 with SMTP id 98e67ed59e1d1-3ae897e230bmr7958871a91.39.1793633490047; Mon, 02
 Nov 2026 07:31:30 -0800 (PST)
Date: Mon, 2 Nov 2026 07:31:29 -0800
In-Reply-To: <20261030133939.630e29af@p-imbrenda>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029143336.390231-3-clopez@suse.de> <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de> <20261030133939.630e29af@p-imbrenda>
Message-ID: <auis0SaMkRB6odsK@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	pbonzini@redhat.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
> On Fri, 30 Oct 2026 12:11:07 +0100
> Carlos L=C3=B3pez <clopez@suse.de> wrote:
>=20
> [...]
>=20
> > > regarding this series:
> > >=20
> > > on x86 you don't care what the new permissions are, because you're
> > > updating when re-faulting (if I understood correctly). =20
> >=20
> > Correct.
> >=20
> > > for s390 it might be beneficial to know what the new permissions are;
> > > of course we could look up the vma and find out, but since you are
> > > already checking the permissions, maybe you can find a way to also
> > > convey the new permission bits?
> > >=20
> > > that would make our life on s390 easier :) =20
> >=20
> > Right, getting the new bits from vma->flags should be trivially done
> > from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
> > this series though.  The rest of architectures still need the notifier =
to
> > tell them if the change is an upgrade, since they don't have an easy wa=
y
> > to grab the old RWX bits. Passing the old RWX bits from the MMU notifie=
r
> > does not seem trivial to me either.

But why is core MM even doing mmu_notifier_invalidate_range_{start,end}() i=
n the
first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip the
"invalidation".
