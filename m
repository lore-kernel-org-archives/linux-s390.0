Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AB405C35
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887044; cv=none; b=lG6PMFZ/oI1ABhBvsyz5kkfr4DmGIZv39+qTDxkMnmEzVjlNxul+4Ygj9wX4Tcs585tMumY87Ugk/Q533a9V8/VjNJCrOZMlMUMazWEclkQnEAsDZ3PUDpLiEWLLP/qU4RVjB7yl6UYuNXYCmqfqwGHVAcvkQTTc536Vh89oxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887044; c=relaxed/simple;
	bh=Ul8JIYV8NOHcJeByflOz/xrTvuzpGiOVrrbJC5VU3O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha2N0iP8N4pJHujsmEZyTuVWKZvaMds1yYv6SHpIH08bx5sUAr0Vh7NhLeHESHCMRpApcL+7LdkTTpoCdM4ZsCV6S81PNxzy6qNtd/tucPkkDFOl1aU+EMhuMup9vnsGbqhmineFh49U1naYN7yumlbu5QQd4V/6YVHsb6DMG+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7PMiyrn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7PMiyrn"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393c93a01abso51581101fa.1
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779887041; x=1780491841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwFizLk7KJxj/hu1skgiR+UafBAS1sHgbOxQgTpEYgo=;
        b=r7PMiyrnEVNu7dScWVxVOT9WxG1LiVCY/inPwtdpYKrRmI9iMSp78pSkB4xiQcEFHN
         CQC2oM75dcl8wSpzmrcSruMrys4X95oUCm1GNHruQqBaldw2/QE+9kBgNBXbUdFkooWZ
         CQiEhlVpTCVVkhyBTJpiU3zXB3DYss+tInZxFVnE/0u0Pd0qU+u+eFHP/WNfgOBcUXV7
         4aIuGAPAlR3xn7BrYUeQ70S+p0HO6PXv5gbE5/VBWfwP3ZgNK+ZesNMf1cwML9aY1I4C
         HnzEy3WgiP9cGZl9OgzA4O7r0Lbl9aM/5gML0eDKThWRo+i2+Aaa65mPLI8tMxKPJUlg
         5+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887041; x=1780491841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwFizLk7KJxj/hu1skgiR+UafBAS1sHgbOxQgTpEYgo=;
        b=MsElIgHbDPAw0ITEF8POBRYYB83EFVG3kvQZIjZ0SxLWx/N3Hv/nFRtyH9HB3tRRbZ
         JENSxbeXZklRT/jn5T+EMNcoRYB6Txyz8FnipF3n4bmqKCqSXLkEH9DZqJ94zVwToCau
         53mn/M0el+soi9czGPHXzXAm/m9PH2msGQIV2aDDO8MdpGJQWjb+ANH9lYc6KilYPtLa
         NZj+QYd7xShjolZTaVRV5yvu8iP4lhAUApQlfVqjx2R/Sbxikhmx0N88OOOPB2NcMzTK
         qIq6SxPi9Eo0JwlGr20U9o76YuRT5y/lzmUxwNcvBeksLjqKnrvkSe2houxF8/MU1BpB
         fEEw==
X-Forwarded-Encrypted: i=1; AFNElJ8Tupspb980BKsnMOCkOpiUPAHvWem0Lrm6KT13Le71KOgPpaaA4AGJrbcFbrwq0bL42QuOAXD7+PSn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhyk+NgexX0/rUejeP3IrQAIMn3JS3KrxXfVlKrZomUQOHcnm4
	WucA4zHHdq8Wu+KQ8aFkYx1VRQHxRhjYBcObT8RtVzDlM5eb3Norkx3t
X-Gm-Gg: Acq92OGgxuvZyc+HbV+ZhS3+/7sCt3f6aw2/VCMBSVbeg8Bv4Rry9IIGQT6BB7D7maW
	bAAMnKcx1K3BnX45R+1TVBlJViK+jl5P8Um8rv5SqTzB2auxN/nVOkkczhpvYylMXdQk61Gl6eC
	scdWJ7NyMRSsQpDmENsZOmONI/IwLpU6MSdMlf06V8B9gH1vlowSWmEY5EISw2003MK3s7FkD5G
	uDmLEn+erPr9l1XRkThf3t4cSc1lW3m8Jrc7f+jxEYXfN9HBQHd+3iM+EqHdmcF7SkIHfMFRY8j
	XEZZyfRjyDxtAM5p2BW47dfq2eF+9bs/ZZmtMlOh5mJV7c5XcV8U0Bvw+OB/rXF9bb4M23mqntV
	Ocr26xEtCwS6wEw0+2/aH7rVQwTxkSECC+vJeQNRv+ri5gXOCHeuq8eUtd48pglD2l7FJqyvzx1
	BWzu6gp+Yb7n9CW8M8kIq3GmlBPVS5ozhGWvYrNFJ3Iyah55PhyBW//AM2fbcxUGoQFTp32FC1w
	qg=
X-Received: by 2002:a2e:a994:0:b0:396:28df:1133 with SMTP id 38308e7fff4ca-39628df1db6mr15181571fa.16.1779887040699;
        Wed, 27 May 2026 06:04:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c47a2sm5793685f8f.37.2026.05.27.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:04:00 -0700 (PDT)
Date: Wed, 27 May 2026 14:03:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Manuel Ebner
 <manuelebner@mailbox.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/string: Remove strlcat() implementation
Message-ID: <20260527140358.3838d1b5@pumpkin>
In-Reply-To: <20260522143111.443100-1-hca@linux.ibm.com>
References: <20260522143111.443100-1-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 16:31:11 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> strlcat() shouldn't be used anymore (see fortify-string.h), and will be
> deprecated / removed sooner or later [1].
> 
....
>  #define __HAVE_ARCH_STRCAT	/* inline & arch function */
...
>  #define __HAVE_ARCH_STRNCAT	/* arch function */

Those two should probably have gone first ...

-- David
