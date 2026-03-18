Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C533343B
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853568; cv=pass; b=CPKGctjgBlkVbnwcX7wdj8/P2Tat5Lxw1hQLqvYOKco+aRPr8qk2tQgKHdNgymJbx47chiSAtsPIJjOjy+LHdtRBQABOV5GJ/GrgbXB0F9Cw/5CGmXYxbUr5JuWWWCxbpMIFvqbAUn4EtTHe3hlaEC+phEOLG1Ph1WaQ3lOjirk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853568; c=relaxed/simple;
	bh=Hz8E05LdBGmu2bfAFeryryBDZivcDYI8jWINoREv7ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6tRMfd30kHBR9q+ePt2n/iffqE4Mut4s6tygGNQs/x1eTaNAVM6sqxDiMU/SAt7Wzn5F/m08DQ47Ioj+jSpD1+JgW88aoNXeb9ymGvee/+U0vry7s7jpn3HkfKqnEX+Xtw7Va+Ux5JZnXidIdY3xAcLPlHj/T+R6A1ReKlssxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBogQ2Ow; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBogQ2Ow"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b941762394aso5636866b.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 10:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773853565; cv=none;
        d=google.com; s=arc-20240605;
        b=ZeoUS0wKOXSMP2VZZiTs+pdNr1X5uM5x77lj1TbkLl47KiGbHYgq/ZJbLZc9GH1FWz
         5cKNYys4w1+Pc2+yyJZK491WwhlnEM7LdtX2rLFPCzQXYqj1TQW4s+ywhTIxcp4UmK5r
         m/jMaqttNRhL+zy0dezy0feWxpi3CCQFo6NBj9mHFWVkMz1Uf5s5WlGswzG/4Sy1cVi2
         3aGSS7EWIEIsEYqrD0vSFlfsBvbVB8u12OJbigkROWbOQAqgy6gnv3K8fbF2jEXo4DdS
         MenfrzkB1bMHeQ8PFxcVftwD0yyhTVOrwE1fsrwJaWZ2+/m0REiY2964pDiSNkF3fSFq
         w3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        fh=lfabN5vejQRQduzOrcIbjyqTpp8YVMi1rHFWsa/QiHM=;
        b=KAhw2/4W7MqfznqvzmRVupsh0x1SiQ8e519x0MTfRkelmFus/yrHLEZ5yI+lZhvsUF
         Vmje8iJxCek2hjxd/rZ344kCN0vn/nJ4hPN3NdmOuyynrPddJrk5D5b0OdiKMsuSnTMm
         n/jN4tn77JbkkZ9SUiQV/O7ZKLwXNjKCdweC0uIXB2Xe2pM7nAmQ9iLA+Z85Icb8ZUzA
         QCjPSCirCGEUazhVfJBtxrPTftoumLVIVteUBFW1lbQyJ20XLbX64JFNhwKlXuc2b/hi
         sbA4YiTJ2QLlA9p1Uf3w5pgKYE4/nXqeUmwEx963YWp2HQ7KmIW2lT10HbqSkTtgVtVz
         qm5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773853565; x=1774458365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=SBogQ2OwU2DRgi5gY+jzSDEtDWk+k1aN43X3WBa7UW0G8we+O1SRWXBH3FyhQT4P6I
         V7hVwvSfsjMpbYRKw2MCp9E4/18/JvQ6HHHqOobD3EMQLGE68RAL5kXpKIkwB4bXyjB6
         UnKg5HLQJgfRNS2n8kPkSqoL/4JwR+/LJIxrjCiyFm58cML43jbKdAS1JEpLstV05RMF
         XR6bUkBdwYNtj8W++Vor1dCJkKb86teC5+ESF9Lmq+SbFGR0CQ4dXcdGS4sV3XmgIKC5
         XuhEI/AF8ii7b5PtvxF5HxsSzYGr7KKfTBRYlW5NSpsMXw2P9b8oYqJj2UbI3x/hyB8/
         2RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773853565; x=1774458365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kATEDVmGF0/O9M3x0zcBp1yfg6DAeXFmwwnXfMoTIKM=;
        b=NLm2yGldgjhRc5AhzrNspPfBbhhb58uizo74AwziDGxh0Amv76iBiLN0T0Kv//uxzt
         mUUcN3F9p95mEWKaKHH6tH0MFpDiA6mGoIPAQ+JHycgypzyFJzHrpT0qM1ax4jpXl0uA
         sU3jwXlqd6x2CSF44zY499vdvceOrewRCM9pj2fefmh8uvuxu8Dx5Ymh7Pj/BRDXZUtM
         6CLsR/Ny7KxOhoy8L59xv6kplJ636jFov2ljIq/kegMVrZt0DVL+rI/bpiT6zGne4mm8
         Cw5GtDGGIMoOnwcOo42OkzB5LQDfY11p46rx7KO3/Ha/7hAfhXY55sC5ZQ2lonHqjVKz
         flEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+XmkWTKEuTh74ieP1sHPLG4WKgqzxU0hriZ4Lb8dEbBgGyjRODfAOafhBbv3mUtUiI/WtpxygwmgE@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNvGOF/SvK20qKJI1c7oUBpOWVFeGzRHDf8rSD49QNaGtP81C
	3WjUZUxvU6MKZijGONOt5Bwr5o2ZThwjipKiJJ7GBnB5FIbAamIcSLannUaR4ZS9WWnUb61Ey8J
	vk99kFUVHqocD4GBKESFU6TyNbmHVzY48MMW6yVk=
X-Gm-Gg: ATEYQzxuBNB3hjq3h8CDs/pv/uFO1nuPFqYLU50VRV0laSO8de2jUpZ9wTgTW4syoHj
	4UK/a7skxgBfFeze2D9otQ4xAveXc2qQZv55nD2RbhUwdrh+0Mr9+Qnf0X1uZTPHpcQBXZ+J2PV
	/Mg1fscGe9QVy6NWU+XP4JmI8Kqnq7smsNQdxvIu9D8o2gA6pbPahVuWomPNBPRTsGX9wET7hO3
	X86CNUcI3lIjpgmDBMWf5Fuu9/acqjjTLkIgrXfuLRMG8IxQW2jupqonse+Y+DmWMMS+rZwU1aL
	ZrI6NSD6BNbXEXmHHSp53NsFwHirphpy7CY=
X-Received: by 2002:a17:907:9946:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b97f4b60eefmr194003266b.53.1773853564611; Wed, 18 Mar 2026
 10:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
In-Reply-To: <20260318073330.115808-1-guwen@linux.alibaba.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 18 Mar 2026 10:05:52 -0700
X-Gm-Features: AaiRm51pAIUhiIslZYeLgnI5zv3XevZ8aLuUPYbmBN9fBas0fAu2t7Z9AQkAyFw
Message-ID: <CANDhNCoFxsXdP7d6nbLTFLOrB_4GnDvhF4O6ZGyvGEVoqV4U2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] ptp: split non-NIC PHC drivers into the
 clock/timekeeping maintenance domain
To: Wen Gu <guwen@linux.alibaba.com>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, anna-maria@linutronix.de, frederic@kernel.org, 
	daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com, 
	wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, 
	vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com, 
	dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org, 
	dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org, 
	imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:33=E2=80=AFAM Wen Gu <guwen@linux.alibaba.com> w=
rote:
> - Following the model used by NTP related code, this series lists tip.git
>   (timers/core) as the integration tree for emulated PTP clocks in the
>   MAINTAINERS entry. Guidance from clock/timekeeping maintainers
>   (Thomas Gleixner, John Stultz, Anna-Maria Behnsen, Frederic Weisbecker,
>   Daniel Lezcano, Stephen Boyd) on whether this is the appropriate workfl=
ow
>   for this class of drivers would be appreciated.

While I'm sure it would be good to continue to CC folks, I'm not sure
if the timekeeping maintainers would be the right folks for these
driver/ptp/ changes to flow through.
Thomas has been doing the heavy lifting for a long while and I'd not
want to put more on his shoulders.

Richard is listed as the maintainer for drivers/ptp/, is there any
reason for it not to go through him?

thanks
-john
