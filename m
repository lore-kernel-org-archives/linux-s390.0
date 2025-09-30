Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865391E1A17
	for <linux-s390@vger.kernel.org>; Tue, 30 Sep 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199090; cv=none; b=AheDvIkS8f91vPERSgGAauk8kzNXyY77fWYHMv3CIqYnxIfam7Ru11NPKnDdVuZMWim6ZAzKNm+ZrtBFjRuQruOPyXepdxSHMY5iSHxRQ+wmSZq1wRbg8uudnfmeHhzVC8+FNh8rfO6CDqT/IKE5UgWXB7gh9AQ7HBNYpVx5FFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199090; c=relaxed/simple;
	bh=JOHkgl9LqBf+BFWsaX+4JXqJ6AHUlrUTGlZ73UK7P2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ9XDWHiSXUtDZ8RDKyigN4nj6KZgBSyrYV5Jmm+vTGkky9htJeHqZ2cDMSX1qY+JukO1eDYYc6t0hhVai3igi1w46q3lQJ24VPkHoWVnoZaGaCyMqZL8wHyzeQWf57uNtVv79JEBmjFS6Kwijj4tmxzGo061d8LGfInsg5ZJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hVOmHIgB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hVOmHIgB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b41870fef44so159989166b.3
        for <linux-s390@vger.kernel.org>; Mon, 29 Sep 2025 19:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759199087; x=1759803887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaVj5/YycRPyG67e4RKcEIp1KOYsVMX34xHPHMeexRY=;
        b=hVOmHIgBo7M11AtRHv1GlREH1soqiw/X4GCrHh8c4r452SJPwwTLpO3pIG15dskMP2
         E/jYKXJ3cxkmUKC8Gsiw3uC7foR0/N54w81y+lwq1iNdLeRv49/Pt0CKOFQZ6z2Nebf7
         TNruc+hEnOhX26JDMrXdTMgoTsl6HGyfnAkzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199087; x=1759803887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaVj5/YycRPyG67e4RKcEIp1KOYsVMX34xHPHMeexRY=;
        b=Ihj3SI75zAqJHFdUqj70sO5RqVuSC43vz4TJA3zW8r1ztxP/EZPQyBFSu4Z7m20a06
         fJFyoP8hftVGqrt+44oGG0twIxpH1UJ0wsjhZJ9f2nQcKlPXj+wDrwBOowz8fZQtZ2xk
         cf9vRI3Wl9T1XUJp+1yFXhoeClDnCl2N/b+zsgJ/Lcr09655CxACihl7s0uM4bzaGcqb
         L0dd7dnnv4Qaq92p/n/fXtnRNLqtCFn2EyQM5HtsPaO4Yrop5SJmzYFR2fUfAPQsboz8
         XjEEZGe6ROuvT2GxEgJr/EDxgeMKe+X1TWWobHDC5/cjuk3CF1la4VRQoEUJiRm1cEDM
         JMvg==
X-Forwarded-Encrypted: i=1; AJvYcCVUssM3xdBz4L0DRVxSMwQJdUu43atpw1YcjHJEOM/zTSXXbocx0pCgbN2HkL+AYLffstUoQUCZNnxi@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJI6G8loRIF6NzV2Wvo/DCN104BoimULGWKxXPcMdt2Jsy3if
	L6Vp7Pu5n9qctBdYLDnzRSCZ+7VLIrCCH4Rrhu32FOZnuWpiONSVOwV4+u6xYZdeTfsQFoTesiR
	oQkAke4a1ZA==
X-Gm-Gg: ASbGncvtt7yAGtnMnBnwjeKErb+amvhBamiHGPCm82JvB5BjsbrrNBsmUh+mhamdBLa
	KeBhgyDPazL68Fjg/iY89TRnzfstrbJ5q0ayh5rq/cRCcKEa0EhtprDlTXqhxkIch/pa0lWYqPi
	tpUhygWx4suZt9k52EuXxHdf8Iq9UeAEPuBZOu8FFxYX6Z6TkVcAptJj50HDIBzBoCJRIHV8024
	hWZoTMNHfGx4EySSLq5U/Uy1SLXTW+lwa0cggvd9NRNx6E4RyP2ZCtXo9vF7hpJHQVkYE3Uo6rA
	EkijOFRUTiFP/+KqpTC89VrGBWLW01ExuZStfiOzMtFc2GzvCJtwpaXXOdD+BqcSHJv3O1FV9OZ
	WgKUGu6tWF36yNbrSIJHWmKsnEpiXpDDmePO7thKorkHoWUHDIBPK70KRfTdpXIrKRRbUuzb4uh
	KcqJw1od/Ywp0sZgfRz0jaOf9NY86A0Hc=
X-Google-Smtp-Source: AGHT+IEyZahtw0HDrwzmk2wQvmxjHdBR2PFP4UqbDJM2Lk1Hotvubrd5y+9VAJDflZ69x7276V1New==
X-Received: by 2002:a17:907:2da9:b0:b40:f7dd:f8ee with SMTP id a640c23a62f3a-b40f7de0aa4mr356231966b.28.1759199086742;
        Mon, 29 Sep 2025 19:24:46 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3ae61b7260sm581496766b.48.2025.09.29.19.24.45
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:24:45 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso10112750a12.2
        for <linux-s390@vger.kernel.org>; Mon, 29 Sep 2025 19:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCTQmNM/vapVd2LRWOnHvZLwJ6+QtQxXHOhm/DI7khx5WhgmRjltXYVpDS6SLnNDtJoJMq0AFC19is@vger.kernel.org
X-Received: by 2002:a17:907:60c9:b0:b40:cfe9:ed35 with SMTP id
 a640c23a62f3a-b40cfe9f8aemr357751066b.39.1759199085323; Mon, 29 Sep 2025
 19:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
In-Reply-To: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 19:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjL1Jkr6L_fak_SDWiHZy3-KFpM9+_oG57G9zPc6yg=yg@mail.gmail.com>
X-Gm-Features: AS18NWDnvEPAl6IWViL1lCt5VhxCXlZKT9yWZPjffZc7pmvLjRMVE8fBlk6Tj-0
Message-ID: <CAHk-=wjL1Jkr6L_fak_SDWiHZy3-KFpM9+_oG57G9zPc6yg=yg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.18 merge window
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 02:38, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> - Make the compiler statement attribute "assume" available with
>   a new __assume macro

Ahh. Interesting. I hadn't realized this existed.

It does seem like a potentially dangerous feature - you get some very
confusing behavior if you misuse it, but looks quite useful for
describing the results of inline asm like you do.

I have definitely had cases where I would have liked to tell the
compiler that the result is already zero-extended or similar, and this
looks good for that.

           Linus
