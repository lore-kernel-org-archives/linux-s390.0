Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237536;
	b=e3FsVvBDueZfOp4WQh3u8EEB81ayoz7mngwrG79HnLu+gTzEULK3vSdIoRArttWJg0X+
	 323kZ6PunH1TngtL2QYy9sk58tb3uD719ZpShNYgM9j9Jk0QYav9lPnMR+IOiuestesVQ
	 9AmpBjG5bhOpespjIoXYDvEE2FtS3Do/03cosBZ5J2H35EgMYWA94aBvPPhmc+ruo33l/
	 3Mc8raEs0/9mgC+JaAX1GbG3U+/jDPbOOywiPiAuTmOniCgT1V85OSrdzo0iNJ4fGQirQ
	 vkZsWybHCIoCiL5/i+cUVYkgYoa59ZZWU/lQfbYRl90PRB7uTDr9Tt0TjaGerG/+d6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
	b=UtSEAB4U1O9aWT4U7Ot7aBuztmDlNeZbX32YFOj+sOpFgd7Wc2HEHVZjOU8z8oRDMAwW
	 eYQniXIJPhmYlCdaQsXIGCoUhRNjEd6p8lZMo9Jtlu5J0JPhh2Yu50MUpVMX5Xqm5nve+
	 vpr1+6vgEkbe7Ce3KcveHEbwFqAo+Xqv/lyXhw/OkZnnjVMFtKUVA6pNI04f7iq8R+GAx
	 eXPJzjqH4w/fW6RPInrC/d9Or4wHUukEFFBaLoWN5RODlU/HC4Kjc/Iz32JCqMAudDR5K
	 oMdkgSgfiLAtn0ehhlJIGlk3TPfyuVoLhLB99ZpgtYkNSNWs7gvcsBqIankkVNpMloA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8ij8Tv1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA5606A31C
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 15:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFBA5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8ij8Tv1
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab4354db11so8335331fa.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 07:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237534; cv=none;
        d=google.com; s=arc-20260327;
        b=Fm8bREAc4M0BqkHk3DyF5EK2kPwjwfv7fT92D6GVInSOX9C8GcCfgqXKpIsP84aVa2
         AQp33ERS2kJTlqbsJZP6MoOXCj59FVeSqfY8d8hXtsYLxTnQn16QJqf2eni46sLugkhf
         W1F2HoYh8IeZAfFGE551Rm0+jHyYzzvxrR/uyICaO5Z+XBO8oehyJLO5urkKGTZF3OPV
         WI1taQCfPt5lD0VNbzGEVUx2VBIbQv5DQSlc2DbsF6Sc6n5Hai50shfpAtmWT6SGNdjM
         5m3eU/wpfcjBcv/Zj+fWw0ZndU+Z1kcOrI6UOmYOmFWdPSOU6+pQblmR6tR4uogFDfF/
         nhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        fh=EeHA4mn2uWdmt7Th1dDCMlcsA5sqGJ/oB8b5vUIpM/A=;
        b=hF0wrumXy5DttRx9q9dfg9MVhcy1DS1ysy1FwbI24SXyt+5b5FjjKzebgnpns+EV5L
         Q+EO13WZQV/uxh53zNXIESntwvnRW6pDOQlcCbEg40+UelTkEd8F8qS+/NiwgRWo96CP
         7B+Jw8G6JCQ5WbypecPLLFz2Mosh6xMmCtZQry/Gqpu5gum5RRknymsazX1vBElEJvCG
         a+Ke6Py5GeezIvuQzBzk3CgDvEvfg8WPqLabmm2Ik0uh9ZprqOJtToTf9emwfSJkzY1l
         eJrXUNdJMEXAi2QEv5tJnhAdNIEuYgrw36FjcsUxxAm151DiiGvOiLixaW78Oo9SClSj
         nETA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237534; x=1794842334; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        b=c8ij8Tv1gkIXOZsIYNgr6YkyMRuFdW/ewb+EHycKB4Fkp1ZkZUOaiSuRTYItYKkj4X
         oX/OZkV/NX5baT22/mAJNIBN4STZnDboEJC2cDEL7lmk7EexFB9YfnedNwc8jFvptmEr
         YC9FshEhENipTaUv/bWfw6vy60EpL6WZD8MpDzRjXSPaJzzCQD4IsEja8SwdYklOyqQy
         PtU5wVsBCfYekTtilM0jV5picQAowqt3r3yqYXRK0B6bPVW/L3WHAYg0g2YOuXzDa1Q+
         +a31ptsx/lHNjs2W0aOO4n5yqPxC3JjlEZrf1s6a/ad1698sxr2K8nurKOIW1LUPYJBs
         nKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237534; x=1794842334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        b=sIOerRW+TARcxW3hAJNqeLgLFs0iVHIxdN2/pKiDAJBB1I1IZ5M1RgqRN/L7aIYgFr
         WmGSXA3TnM39aglksBdCQlvX8mM2aCjN+FjBW/NOfXDwgH2i2wj0CRL64UIqsi/wQGrQ
         7gjW12Drv0xPMWrUc9JO/NuI1RamHNalxkeL4k6uiPlRv3rmk+MOBVJr2csNZ7/xNUKc
         GCd1Om9xmkCKCadvtUvG/ttAZvR3NPkfpcN6d7ejh95Dt13hzymxSCmwEkW5M3kkSC1V
         rrnTrLPSOmHT40IeGq+gV4+IwwGahEDOaHHcEZzxG20W0GSUKRgz/bvliVzNOa0FrBC1
         hqgg==
X-Forwarded-Encrypted: i=1; AL+hErHCx73SCTrw3Ke17btsAYnht/0xSvem94Wlqucv3VNq4t/NCpa0lh0MA/+c7Vckw0ayAtUdW2bByDXp@vger.kernel.org
X-Gm-Message-State: APuU4Z9VosH0MSEsmR6bQbP500zNpxTomamclMObiW++6CPM04JruMtu
	+IcpApEMGPBfUPGUDpTZirgPqGUq4QeCvNjVlwlQOqmZ+VATsh4+0mNDU5RQ/wjY5/Dscx7rvoY
	WfGz/+7o87mpz6n3137YGF5ulVwV6tfJc4A==
X-Gm-Gg: AYBFou3wNEncPAPfsTadnc/5/69m1AAkYL3Yd3UfLW/pxN0LdaI7XIz8Ds4WvJ/UH6O
	USkVYKQuqmS1lsxftsglHPzO21Uby4io9jKhJObYDcf2dCJrEmq1pQSx5QUFEIPw/vVXzukOChO
	2myvOApekho6K1tYG8CLjm8+V8DnVR4BIzr/VXitNbRFsJQHXlaUFmvSc9rfpzSsAcJ5k1nFE2y
	L7zFtnYeKmXHiTkMRGW6TUpc+gPfbMKz7P1kzIN2Q5L6Uw05piXloQzLM+4EsbvY3HWYNNQKyZy
	yXiWGgxD9yV1Qg3NQKpq7gNHaTYQSvt6c42SqdiDPKOrKybKA19SOI2QiqEnwKnwd59qXJxyKmv
	dddbd//aywBV0oulsuE2vNPbixLXezDB9kI3VAYgseX64Jb2SlE5tah4HfjQ=
X-Received: by 2002:a2e:a5cb:0:b0:3a6:622a:2cad with SMTP id
 38308e7fff4ca-3adfa40ab84mr9712381fa.10.1794237533641; Mon, 09 Nov 2026
 07:18:53 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106190401.468289-2-oss.patchbox@gmail.com> <e597eb85-6c80-416d-bee6-2498ac06de5b@linux.ibm.com>
In-Reply-To: <e597eb85-6c80-416d-bee6-2498ac06de5b@linux.ibm.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 9 Nov 2026 10:18:41 -0500
X-Gm-Features: AclHuK9xISIrL9ID9x9MQ91_XwCy5vI6jq1cGcjDxinZF-wje8KKP6ZM3M4rjLM
Message-ID: <CAGG=RgACO5r_SXcx26tUuQ96b_sworbA2QQPctGTw=QibKpwoQ@mail.gmail.com>
Subject: Re: s390/vfio-ap: NIB unpin when the IR bit does not clear
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 10:06, Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
> This has already been reported via an AI bot patch review. There are a
> series of fix patches that includes a fix for this. Short story is,
> the AQIC resources will either be leaked to avoid the wild DMA
> write - which could occur in this scenario - or they will be freed to
> avoid a
> kernel crash under certain circumstances.

Thanks for the kind explanation!

Yuho
