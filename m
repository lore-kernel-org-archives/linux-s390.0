Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AFA935
	for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389348; cv=none; b=FamsUeWd3nQAKiIIu+9Yu1of8siq9cQsIOcXiI0B17OvAAS0Yo/HwPProI7TOsUO6fBOo+J4rrZ6yRcyc0iaSIuEEjF25bDqtqsU5ZmgNjf4ZxiR+wJspmPcBPufRgz+sdZVSkGIbjFdqJA0m5RCHeP/ppXCOd2vZg33eceVdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389348; c=relaxed/simple;
	bh=hjYKCzXkTNj7DEe6K/168WOuyg5Vvokvimor4gxXeCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2b9MAQ28pCl8Mw+zPRAKQKgHkWzJTIfZXve6qyRmlz68eRg2eCBY5ISkm/N9Ifpx8mI+EZu/LXW+walzLKy2ZI/P+ksNo6Nm3ngE5wYYLyK87S4blbp3sTOQEirrrs1Fg548sS2TSlxRWZiSvFBHQQoLqeXJVvtqpNLSC1JDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6MYu3D6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6MYu3D6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742389345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjYKCzXkTNj7DEe6K/168WOuyg5Vvokvimor4gxXeCg=;
	b=E6MYu3D6kTIt3SXbKOq3jFyZqsAXjsgdas/Hw/UYM3bpkuUWfIb+PE1yZVxzzFEQkDFbz+
	XCmh+ukxxaqkAvG063mah9L4fBePjpHUsGfx3V/x07Ufk7FIv/yjhxSA/K0Ei1GGcvSj8s
	U48NpjoMUq9Z1riEhOWrAeUnLnSBDcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-hdAxUKnhM_-ikiaa28DvqQ-1; Wed, 19 Mar 2025 09:02:24 -0400
X-MC-Unique: hdAxUKnhM_-ikiaa28DvqQ-1
X-Mimecast-MFC-AGG-ID: hdAxUKnhM_-ikiaa28DvqQ_1742389341
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so3435378f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 19 Mar 2025 06:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389341; x=1742994141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjYKCzXkTNj7DEe6K/168WOuyg5Vvokvimor4gxXeCg=;
        b=LYv5lcvssj0d6GnanFMYvyAIt2h+36iQUqx3uIeR8K7n/D7sxdRGDi2L8VMM/gc6Vj
         HOaDjO5MCSMeplsSr+y1Lb/SNrgBEf/oahRUitH6FiddV9vpiV95TZweELDVkJ1aTMON
         ksYaU1+jec1iBJAICnpJIOsazaVhdqdksuRjqbdEDXo/E/xBFDvwYLpwVXobPGoTHEoJ
         RU/VpRcXd+6WWxnIRPVYxe+CmkBbQ3ZnEagoAT6S5WuQEf6uD0F8pfpVAtY2JL49fGBg
         sGO9mcNC8lpd/Key7yYGAeHwXuXZ/l8LTaWA3RZPQUb6ZrUQnKaV3+LkZWNYUaUDCbVP
         4n9w==
X-Forwarded-Encrypted: i=1; AJvYcCWVYtlPOhaYD2aTDUMRRamWuFqih7aQQ3xTlnY1xWAH1tZm10RTll2j+VwV9KzQjHG8jAO7QMCZ2kNB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nfEbHj0buZAEQ5+wYE0CY9xobuYeHW1YsN2KWTRh8ofENPUo
	Cpo+8BaN8veFeCtCsyQNBPSO1Vm61YDghL15qr/4pw2fTE9PnJ0XGfzRF523o1x0Kri/XkwVibR
	oUC3gujpaG+joXQVTWj3qYgnHUAZakdlU8c6dvTSHnzbk2WNOZMybzts73lAvaD5GRCplJk/cY1
	26Z0MrC/BABl27H9KVW2eoO+EP4fQAIM5AeA==
X-Gm-Gg: ASbGncve4UV660WXq1IQxJhfZsD6fkA357W12Cr+p5xFOz42ja5BEYNlm1uZbBIaFK/
	TfL6JDU9qYtOXU225mxbYJygaCNp4B9t6dragPXr9HYgZ6w8eb0M/1hTpBjara0/VfEYf4JkxQw
	==
X-Received: by 2002:a05:6000:154d:b0:391:2db0:2961 with SMTP id ffacd0b85a97d-39973b50772mr3127274f8f.38.1742389340958;
        Wed, 19 Mar 2025 06:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6HfFmmSP0cjkdSlhe7K0qb4m/uOtm3qySw4lyfLWCTKjI9y2oVrZxJTWh4ZUa1nmkABFImIaCl2RPU909rU=
X-Received: by 2002:a05:6000:154d:b0:391:2db0:2961 with SMTP id
 ffacd0b85a97d-39973b50772mr3127190f8f.38.1742389340432; Wed, 19 Mar 2025
 06:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314161551.424804-1-imbrenda@linux.ibm.com>
In-Reply-To: <20250314161551.424804-1-imbrenda@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Mar 2025 14:02:09 +0100
X-Gm-Features: AQ5f1JrBHLjAttbOwvhIUgFHgjpUlzmrMNLWo1ZIkJbVPOCEfLZwT0qvNaInPjU
Message-ID: <CABgObfZ3nf-+466VWQ41GZ5T8cxo94eZmZJhK=jkCeDSDxfh6Q@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/1] KVM: s390: pv: fix race when making a page secure
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, 
	borntraeger@de.ibm.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 5:16=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> ciao Paolo,
>
> please pull this late fix for 6.14.

Done, thanks!

Paolo

