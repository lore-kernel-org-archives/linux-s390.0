Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F52045AD
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737585; cv=none; b=Bx0tVMd8r5Y/Po4hg6O+2u11jk0atLmjkoUYI/wXdpl9Wh4RC4+5js0ZE6qqM7p1LIV5yXSQFsdry1huSnFhAIwH+5NAZU/Ntj0upO13T3Qb37UjXJE6zVUqbF0y6GEyXJUR7OIGUbhwx7BkljQ83MPp7tAmRa0J8v3ujSRNx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737585; c=relaxed/simple;
	bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCVHX+NCDKv2ySat4jNU4H8ZgDtD859w8YctzRXO/AaVQLIIjBpajgr9U//G6izUNvU5V2svNokrWu/5anY4Ea2z/gcBt3VWwyjvdRXX1vUGHBZGxRj0kYscqaxr+aizyRrmYlDlK/3vq+dPi/EFa6DuqIBir9YidUlN75d2JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P7l8By8+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P7l8By8+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b043a33b060so93993066b.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756737582; x=1757342382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
        b=P7l8By8+4XE9YYtGkfhSvUvaLgl4Xj15mlqqx/eQuQkvJe2eXJG1bE8ecAK2W+KnI2
         5vGNhpoVYK3Tu82jRS3+jZF+w/u7KCSdqqPpvRL4KsNI9fhbk0eJdMvNqPFNeYbSsLpk
         ZmyeSRAeyxWFzcAlaTaCEClS+D3lA3tLCZUaLSK7vmduS7tkQinal12YAwjQGJ45sw9O
         YEUDKk/BsZZr5D4grqjRDauozq0hcS7dT7vVQX8zrkHujB/tg1DTt/EoqgrUybARY+0c
         EAWr3CSgV2fuyIUL1fqpg1RdPB9M3lqZKw4aMQzQKjcpV0EZ7fXbeDWH9lhoRHnJ6pw4
         qbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756737582; x=1757342382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htQYfrQvt/cTrdobxmgH73W4WPpszNwvgv/0+a/GiHg=;
        b=p5EFOXQfNv5j9jkrOTsv2ODV+Zylb5DejwAUfVZvjqlZceTdTqQYcin6hFzcUKWtxH
         SBRFespiRWXKSuG7eD675h+c9z5NJeXLtzNG8Pttwgxq4rZZeHZt1scz2O2t5m96ySmG
         kBEX30qrROEvo2hzJdwm+eErsxkD2ixZsFe3gM/AN9gXPcvUGxRb2Q71XuMR84gbelJc
         Gbq93plI2II0Lf87OV+JO+CS8dYb1QbJjSbUQgxxpl3MTdazPH1wK7/gjt8XpUklkD8P
         mTfKo9PSWDiv0MRLZYCGnyPoIIXwH2EKma5t3N11bR0+1xG1Etsr+6kVfRL430cEL+Qg
         nbZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCXan06LNkqJhLkSNbnQ12emtyG1paclzjCqS9zDj/H+EOrrDYazY2TuvEK0yjvNQu35IlRhi7Mxd/@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhBNtv26zs5NvQI3lcJQtkoWB5UAr99LNzhIoHpEQB8Z1Aywo
	d9/td0W9cKkKGYx5RRbYdw9ZvhjQhYmrJqveeFGr9w3M5b9EoVmEh2w2+WDCB7pLSDdOl6NrOuh
	nvAVX4J1Vt+0gfaMClm+kcTFAh8VVpO3ApGa/UrS5Jg==
X-Gm-Gg: ASbGncsFrpvmaf/EMQdtIDIPoY61+AD+EaWx91DKX5yHAeQ3VyBxO8Y6ITd4mqQuUqr
	jD+yiH0JPF1Qc5vX9CWwQUPpnsqbrEa1vKWoY+mucJi+B04YYUUfJ95CkDFRfK6KLu29BKfCh4s
	7khVKYpfw5A/JUfMxN/hw+jyRcu7L//VuTPwpNcYd5XBes/0bRw+PGGkOYOaVdbcOZOTT3zlC6b
	KKOXykVp01XQLimh9hObdQbIwq50A5yu6WXhPqrpP+cUQ==
X-Google-Smtp-Source: AGHT+IHTqF1JAmNmg2OO5LltznXi0o7wJKri+X2655du84wb99ZGTC9056cINHWh8si0MefDcLENJcuak3msFoGR/no=
X-Received: by 2002:a17:907:1ca2:b0:b04:470b:64a5 with SMTP id
 a640c23a62f3a-b04470b665cmr30691666b.36.1756737581693; Mon, 01 Sep 2025
 07:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com> <e509a5c4-f71b-4fcd-9776-6a3d39761b4b@redhat.com>
In-Reply-To: <e509a5c4-f71b-4fcd-9776-6a3d39761b4b@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 16:39:30 +0200
X-Gm-Features: Ac12FXxHU5onUYdItrFe4rtUI2ez9M9oa4kNLp6RrsUlpVm1LJn2X4DtIQLritA
Message-ID: <CAKPOu+-ti5bL6YLfBGMt1=3c6gjLMeBqmHGPD1nQC2J9uU9mPA@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:49=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Not only test functions but also some other "getters" in there.

Oh, I thought getter/test function means the same for you. I'll amend the t=
ext.
