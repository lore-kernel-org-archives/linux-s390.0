Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93C208B0
	for <linux-s390@vger.kernel.org>; Fri, 26 Jan 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291865; cv=none; b=HUx6GZCPujxWuVMMjiQx4DAc+YxgFI1mL5dDxtgRHIZ4L1Z/JB7GPRdsVBGuMKXbpZEVZuZz8lfz7Gml5TOo43HlstaOqw/Lo0lTTKwJY2DirRSQmVB2RGfWxt8E3Nca5XuUgaps/cPwyr6ADi1pxdRNqTJuvcRcraQGJT52oX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291865; c=relaxed/simple;
	bh=Q7oZu/1YHI4BPg81Y1ep2zij9N2PEYAo66F5LlRnWfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUlhrSXX0axUI9Vp4O/gRYgha7fCeF98Svs4NI4HP02DwyvaQ8UPG3LmoySmFGMM0qJpiz6BWuonyGN/j/tB3XC1kcztNd4at+Z8HLbtGT5CKZS7vvUWniq3ZET4UFKg1C2+LR+xUxXZuTyjfffs7CB+kcH5Q/WbeU79D3fJpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2pjUe+D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2pjUe+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706291862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdliqqq6y8vi1zExRryLtToJDjJljYRysBrFuRmBXOE=;
	b=i2pjUe+D6v4ZotlXzZTx8cOix6ZOcUKNKFeBLTTSS08RU8edVChbcPvR14DY+qvdiKZmIj
	LE1de5naPAcHdauSoq7sljQ0ammzA5QJwVAOYppJ4exC209FXggOcCKBKXuf2wSZZ+TC7S
	XDiDmhwbE3KmQqWEUBFPO6qxvcMSNUA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-euteW51yM1mcmDPhR5FNWg-1; Fri, 26 Jan 2024 12:57:40 -0500
X-MC-Unique: euteW51yM1mcmDPhR5FNWg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-46b32362dbbso71794137.2
        for <linux-s390@vger.kernel.org>; Fri, 26 Jan 2024 09:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706291860; x=1706896660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdliqqq6y8vi1zExRryLtToJDjJljYRysBrFuRmBXOE=;
        b=qWgrWbG5b/FKT4DJ+UBAuyuCLim0xCWBNt5Ui9fDk1MJONZYAtHXNSwlj0NTWG8JEH
         85UIp9TgrUWeV/gFUE3nBSrcMqSdSNLsicwZupabuQ0sCgNYVM4PF1CbXSjNzEKVFNEG
         VBQ2SH+yEKiy/Eiwsk87B3Lr+/w83SNvddf1/nlEd/kbAMNqnq/U12w90AJq8dp1koNO
         haxy9kb172ojDvTXHzvLonWQb+WrtePEiVOLf40IUvHPtQhsbjgkmDjyKpD69HJaZ2dc
         tDGCRgrXy0bDivu+1u6vguhm6YvjavNTDpC5kRKr+NbHvNs+4EomRBW5FDLSEQN1vcTk
         Pmvg==
X-Gm-Message-State: AOJu0YxiVFDbF8+zU5xFFIAREfy2Ki8oxU2+G05agNNfIyoQQsOJuhoq
	cZHnul3Aye/XCsDRH7gfAQOW7YA7xtywVbTHGq1CES0gYQyWQILAPbuPaQN9Udx9DBGGAR01vI3
	r4i+NacdP4pinbOwKXM12fIzsnlj2KDDAOYK/JGGOtrlOFGiIGdh3WmWQ+ijuMsPnSVVeMsiNeo
	K4saza+9uv9HPdic+udh+/mIWHpAI9WBp/Sw==
X-Received: by 2002:a67:ed8e:0:b0:469:a7f6:7e14 with SMTP id d14-20020a67ed8e000000b00469a7f67e14mr105507vsp.24.1706291860315;
        Fri, 26 Jan 2024 09:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4U69LLHM9eQG2kEV3etn1B4gahOwPpnU+IMnWvmuFC5o+U20i9fIcxh4YhMQSs8aBMR8LXo3uuszuWRJ15Xo=
X-Received: by 2002:a67:ed8e:0:b0:469:a7f6:7e14 with SMTP id
 d14-20020a67ed8e000000b00469a7f67e14mr105504vsp.24.1706291860078; Fri, 26 Jan
 2024 09:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122162445.107260-1-frankja@linux.ibm.com>
In-Reply-To: <20240122162445.107260-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 18:57:28 +0100
Message-ID: <CABgObfZjJ5sADB0+aq4LTtKsmV0fBKCi-umOqQppC0=mgUMegw@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: Fixes for 6.8
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:25=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> Paolo,
>
> please pull the fixes for the following two problems:
>  - The PQAP instruction did not set the CC in all occasions
>  - We observed crashes with nested guests because a pointer to struct
>    kvm was accessed before being valid (resulting in NULL pointers).
>
> You'll see that the fixes are still based on 6.7-rc4 since they've
> lived on our master for quite a while. But I've re-based them on
> Linus' master and your queue and next branches without an issue.
>
> The following changes since commit 4cdf351d3630a640ab6a05721ef055b9df6227=
7f:
>
>   KVM: SVM: Update EFER software model on CR0 trap for SEV-ES (2023-12-08=
 13:37:05 -0500)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-6.8-1
>
> for you to fetch changes up to 83303a4c776ce1032d88df59e811183479acea77:
>
>   KVM: s390: fix cc for successful PQAP (2024-01-08 18:05:44 +0100)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> pqap instruction missing cc fix
> vsie shadow creation race fix
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   KVM: s390: vsie: fix race during shadow creation
>
> Eric Farman (1):
>   KVM: s390: fix cc for successful PQAP
>
>  arch/s390/kvm/priv.c | 8 ++++++--
>  arch/s390/kvm/vsie.c | 1 -
>  arch/s390/mm/gmap.c  | 1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

