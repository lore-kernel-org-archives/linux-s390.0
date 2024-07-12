Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419717107F
	for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797841; cv=none; b=RluK4KtBn3yMFHDFHlREOVoZVn2Zd3MlaVXAHRWHShNgy7UOXE5kJTebTdfp7X7G5QLt6EMtXNR/a/9OIBxmsW6yzjJPEyLEI/1o5rNFKTwAzdsfYEoMAJIPsWbmVZUHrcNp8k8XKAco7RytjaDpYNAGXrWHbfEdWisMn6at1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797841; c=relaxed/simple;
	bh=2EqlVnEcPlUgYU2TK7tDUJK58Mn7vIB+p95JiCF5dq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg9aDNkLHP/DAa4ne4QAcxNlFLc4V5CpG5THbRW3AOHKmSrjj9U9e6Q618oFPuORsLA4pQc2DoTC54uJ5suHS8nsTAuS4V+RcTcFPJOcxtEF7SqrmTOiWIxRFWi4HR6VJsXqcsCYsFjlYYnQUfJqN5sJnELVTeJiC+LPEad4lKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBxNIVFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBxNIVFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720797839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGzOi0mcN1gpHM6n5xGEHSGZPwc/Apw3EWbMa56Stsw=;
	b=YBxNIVFQhVZAXonlkW0HVLEwXSFyEXXbPbRDwjfWxLsyiBGZSOEHXENazSeWt+WpIf0LPR
	1IpflCznD8Dbso1yEgyZcdhBYrQ7tm1UxN0ZU+2k0pM3NodxO4f0FFwxVzqdSNcmEyudHm
	kittYuW0I269MoZdfv1lIH0j6odfzw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-4V2pWeyJOlmodP4G1UnwYQ-1; Fri, 12 Jul 2024 11:23:58 -0400
X-MC-Unique: 4V2pWeyJOlmodP4G1UnwYQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367879e8395so1179829f8f.0
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2024 08:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797837; x=1721402637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGzOi0mcN1gpHM6n5xGEHSGZPwc/Apw3EWbMa56Stsw=;
        b=j3gJ06m+ctRGVoujwxthfcoe5VHS8Y62GpVcbzU4VTUclMFoYii4JQHXKDs8lQmimN
         D+HsV5pAZ039r1r3dopoANlUa9VyCysKbgvV+yEaHcPqAymq37NEhp3xnXQuk5Vbcech
         QFdvjK4ty9LM3cnbCZKJ8nYKyr56Gd8R7MdKRWy+mQaOPKm7DSH8L8eV2KIZ4kHs3dm3
         YkrQQiP52whn+/vDpyyTy4M2Ns2Snk0NynLZhzg/tt7Fv95NZhWzcbF9h7Es+DeKXYBm
         U+G5mnF+9EMiCEm6SCO3E0IE1VW8zemIHIu4PFO7/1CKUL0GZqGCVPCFkwPciVK42S/g
         1YVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/d0IaGHc8Z3l2EmR9SFDE3A9o9OQNRJyzeyWQySi/vPu4Kncdp6guVcTsrcPXKndUrqrjiN1dYaU8Uzl4OBkZbslmCvyNVmwmCw==
X-Gm-Message-State: AOJu0YwzV+44yyCB1+u9da09xZ5K2dmOIcX0bJW27coztLrH5CefcQ8w
	LJtuk/BD8BFyKsDiGu50zCkRgMvN+ICHqfgZG+ltdJs6BTTQDY7fNQO0m6XKGZ+RKC1EgIrM3KO
	p1nRRd70yOmabWWhMa8A+GdPcLfcoDKvGp5Mv7kNnYsfPa6zQ340DJmdyxowitj+Uzjs+4GDKt4
	kEMRZrnx5oCKhZup4rDLA7IhV2SGZU3utP4g==
X-Received: by 2002:a5d:4ec3:0:b0:367:94e7:9591 with SMTP id ffacd0b85a97d-367cea9643bmr7473293f8f.36.1720797836990;
        Fri, 12 Jul 2024 08:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWWWA6ULb295t40qJUfl0BIxfNmBzQZfn3oLBjJX3wQ37ZJrJcc4UwCuC4zX3texJ5JVV8/INj0bhDsdt57cc=
X-Received: by 2002:a5d:4ec3:0:b0:367:94e7:9591 with SMTP id
 ffacd0b85a97d-367cea9643bmr7473274f8f.36.1720797836621; Fri, 12 Jul 2024
 08:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110654.40152-1-frankja@linux.ibm.com>
In-Reply-To: <20240711110654.40152-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jul 2024 17:23:44 +0200
Message-ID: <CABgObfZzVwpewT88=dPRL4vp7v+HR79dd8=L96ht0HPxvzKkyQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/3] KVM: s390x: changes for v6.11
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@redhat.com, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:08=E2=80=AFPM Janosch Frank <frankja@linux.ibm.co=
m> wrote:
>
> A couple of minor changes/fixes for 6.11 which aren't time critical.
>
> Christoph's ucontrol selftests are on the list but might need another
> round or two so they are not included but will be in 6.12.
>
> Please pull:
>
> The following changes since commit c3f38fa61af77b49866b006939479069cd4511=
73:
>
>   Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-6.11-1
>
> for you to fetch changes up to 7816e58967d0e6cadce05c8540b47ed027dc2499:
>
>   kvm: s390: Reject memory region operations for ucontrol VMs (2024-07-04=
 09:07:24 +0200)
>
> ----------------------------------------------------------------
> Assortment of tiny fixes which are not time critical:
>  - Rejecting memory region operations for ucontrol mode VMs
>  - Rewind the PSW on host intercepts for VSIE
>  - Remove unneeded include
> --------------------------------------

Done, thanks.

Paolo

