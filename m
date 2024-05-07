Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3B50A67
	for <linux-s390@vger.kernel.org>; Tue,  7 May 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101328; cv=none; b=rKQ55bdKdhIfRS9FX/M4abpBMnJqBg1GVZQ2lV9cso1uvtAF+qYDr5AL0e6QsgTIhURjUqCrYuEoVRIYanrcRqSwey0HwXWQh5XA96LJqPLfI514DF5WuG+b9VQWkP1weE4QS9dr7Zl59SafD9JVTXGKxJ59q7LmHQ5F6ZCf8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101328; c=relaxed/simple;
	bh=lnmeGx6mM8HK2cbcBMXEki7Leq6zV0uSfpE3Sd53tq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NblHAGjk+Sy24Np6c+JgaxXwu7gf2q9BqFZEkHTZDoAZTc/FfRm5xJ4fSzEFO7oT4rTPEueDrHKB85VAk0Rp20tgjI7Bsh3V6UYhCQG9WZiJnm7wwHqnR7vtY4hTD8q4nEV624EBlyhDLRuK3+rYLFHWIWppUPUkIwc38HKWbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9K57g5L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9K57g5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715101325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35j9M18N36vk6wSyApQ+5MJ9yl+jkARaDRgd2CC1aRs=;
	b=G9K57g5Ldj8+5aRyDO4TSPNhy08JNth3j4UVNl9yIHy5iaoSgq2a4CY/UFaKfI6aoTnk3i
	8MfIDd5lTDxITCutQdovtNiFMkRK3yWqiqCRLyMEkex0NeUGxSMZuIxpoUA0V75J0eKeix
	TmPLKSb4duF5zlpL5B26dd+fZ6NE4Xk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-rjc_9USPMg2RILvfWyZLpg-1; Tue, 07 May 2024 13:02:02 -0400
X-MC-Unique: rjc_9USPMg2RILvfWyZLpg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e289eec4d1so31611441fa.0
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2024 10:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101321; x=1715706121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35j9M18N36vk6wSyApQ+5MJ9yl+jkARaDRgd2CC1aRs=;
        b=jpIrqWZJKj1n//5lg/YxFiiIvehJCCcLnfKraHUfUKzs7tBCnEFsfhk6QKLxRqK2oE
         /03IWPK3Au7xB2uj7gT9byVXdRhqaJ9fvs+e/1oaWBNotCaK39O8U8Cxdhi/BnaQEUGd
         BvS18n/SPseCQZ615PwXJd5V7aaCdflHZhkonL+PeZdSQbTU+V0BRC7tbeNMWr9BKeli
         3DAxBFr1EzhODwZtLIcaF0nQj9wAegvdS8wjsF3jiaraC1zgL3Pg0xz6mDLQNA3mGJDZ
         0dwdk/CRt9M/DNLpRZBLBvPZNSiz4WJykMLBiGAwntc6dMAg5cG6zFMpwAxCs2ScVmVe
         /YHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSF6AFO0Dshm//J1pbEcINj5XRxil4TJRIbYaK0E6vvWhIqnapNVG37ZGGZOlAteoa4nQQJVncg9TpYfXK6lKWLAvIxYFAdHz07g==
X-Gm-Message-State: AOJu0YxrzCovf9jisiX3Pdy3huA+vNljkE8jyQUp54Z7dpk8hBRnFOU9
	9AARqQtKALsxcSQ72Xmmvzfe4VsWFpxyoZHlUzBSFySlmpVhggvWGEf30Oy9mUl0wMaTH7apNHZ
	l+CIfpsxZun8mASnn3zT+kSUW++vbSdXSluP4hpjxTUFKK/HsTdAXKwRfOKOOG594ndg3ZfiFMN
	8RPACDwbxNFiPtC4EaZwoAciHU0pIslzdlbQ==
X-Received: by 2002:ac2:5e30:0:b0:518:ce4b:17ef with SMTP id 2adb3069b0e04-5217cf3b0dbmr60097e87.60.1715101321278;
        Tue, 07 May 2024 10:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6IWm96F+cIDzth/uQd3l0oaQARW+aFQiEI+UhoNsuY9HQ0VD+mdg3aAHEreT/EfAicuI1kFYJx5l4fRs6tJo=
X-Received: by 2002:ac2:5e30:0:b0:518:ce4b:17ef with SMTP id
 2adb3069b0e04-5217cf3b0dbmr60070e87.60.1715101320848; Tue, 07 May 2024
 10:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507122945.2571-1-borntraeger@linux.ibm.com>
In-Reply-To: <20240507122945.2571-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 May 2024 19:01:49 +0200
Message-ID: <CABgObfaww5Dtp0Ji1ff99RrW11stWhf_JahJAyUwpV=RyTxpCQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for 6.9
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Thomas Huth <thuth@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:29=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> one fix for s390.

Pulled, thanks.

Paolo

> The following changes since commit 16c20208b9c2fff73015ad4e609072feafbf81=
ad:
>
>   Merge tag 'kvmarm-fixes-6.9-2' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/kvmarm/kvmarm into HEAD (2024-04-30 13:50:55 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kv=
m-s390-master-6.9-1
>
> for you to fetch changes up to 175f2f5bcdfce9e728f1ff956a50f28824d28791:
>
>   KVM: s390: Check kvm pointer when testing KVM_CAP_S390_HPAGE_1M (2024-0=
5-02 09:41:38 +0200)
>
> ----------------------------------------------------------------
> KVM: s390: Fix for 6.9
>
> Fix wild read on capability check.
>
> ----------------------------------------------------------------
> Jean-Philippe Brucker (1):
>       KVM: s390: Check kvm pointer when testing KVM_CAP_S390_HPAGE_1M
>
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

