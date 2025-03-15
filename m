Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE945202963
	for <linux-s390@vger.kernel.org>; Sat, 15 Mar 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050545; cv=none; b=SDf4CFEfHEfOVy6iJtm/RwDxafzxALJpixZa6WT3WadGX6Te5nGsyQlbKfTPU3NAOmVIMpsvxPZzF84z8PCB8gJ6YWoXeq5lQclP+AF/5Ix1Uj0mYGCXP5YpluQL3PJdsGwm3IwgFoQ5GMJwx0lNscAwhO0DinkVfW/dirczAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050545; c=relaxed/simple;
	bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=aK6J8SL0vjQXG2E/2aLL0s6rWlMOxXFj5IeOu8aVYjYCUvqsFZyDOIqDGbAZpPXRkh6qvZFktxp5rih3fBGZgdJp8F6qejdu34XMI2eFAzzbUa/f2ZoSVohZotc2iiYTCept0Nfozuu1Q/ZV9oQmFSMLODX0KdR4e30VvK1cWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmSjBQ9i; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmSjBQ9i"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fee4d9c2efso1027020a91.3
        for <linux-s390@vger.kernel.org>; Sat, 15 Mar 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050543; x=1742655343; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=PmSjBQ9iXnLJUW2idUj4k2rryQQVbg/u4JfQq9Z7sOLQAWkwBeOXLDdObkRKX/YwA5
         VZKXGNshnwN3FzHVih5sE5LsjfahwEYo8mTxY+LFfphTknebNzB/lfuO8AgeHLHwztzw
         hsQclR4CmM2Swg9TQqh+7yBxVTAaMFPsWwwstd/omtTWD9gRwkFkiw3zLoYoHumY5V1+
         OGK3MYKiA74blXWHYoH8LmYf767Z13BBpm0aBv2/F0xio5h/xsfr2n+3+iVpbq4gm1iX
         bEVfjWwVFbRAM9csDsJGmDcIdCcvalQvxWekpf6eq4XRcvLFvrtmew58O7LnVVFdwxXC
         yFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050543; x=1742655343;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=K88bIohKeP0TJ+re1U6Ru0Wv4fGc3GWnStXYSKUn9iWj+MyMhn6gRmuEf5kGTiMJ7a
         VwjzkGXxj37Pz8lInITLrRnCnnGS8riv60+DbaNp98P87tEQbO54r5/R6DXrkQQebeOM
         iqnD9NafXpHUAyAPuLWPDIscrJgRSH1l06FpkM9yFx5ynPJQs1x/AavIM5fI52dPWJO5
         4dKAy0UvJY1AnClkMaXFi2+4QESKeknW1GK35EAlsuDlT0f5p4IgbsgfwX1g4puhKf+/
         fG+27+2pXDAWHcGLXJV+s92WSpW8+pT+RlsDlXhNC4EancsBqYwa8tNoImuzB67YYtiz
         xc6g==
X-Forwarded-Encrypted: i=1; AJvYcCXooE9smzTAvpix78hffTUk31tXO4ACuw4QvTHDc1xdXb7hMox34ri70Kz1rofTIfeqdSXraiCKuu+s@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/asUPL6qEdj1KSNMUKkf5BEqEMGlboTItZza9kXDwi/1c0Hu
	xlGQSU6cmZkCbVAoc9N/2KioOo2jwihvPbGt2ZgrLu00yrdm8q3f6CAkx88YlaKniYQ2Q1Mvlzw
	MjXhGdVmAi9Uu0JR4u83TgKRtwG4=
X-Gm-Gg: ASbGncsb0WuitJl3oqJwcR+U+ddANarnHXG6OjMJ6ggVP5lzQhTN1lONBxvLWOcp6kp
	3my37+vPENLNzRIOQEvBPnKsvO9JULgZSbGS2eU0p+Pa4iW1VOacjUU4+EdQnRmgt0ekH6M3Sp0
	zmY8WwhKTaaNTp91HIMlvFf5U=
X-Received: by 2002:a17:90b:2e44:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-30151cc2490mt7920218a91.16.1742050543260; Sat, 15 Mar 2025
 07:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
 <Z9ErEBuMMvd6i2n9@kernel.org>
In-Reply-To: <Z9ErEBuMMvd6i2n9@kernel.org>
From: DiTBho Down in The Bunny hole <downinthebunnyhole@gmail.com>
Date: Sat, 15 Mar 2025 15:55:33 +0100
X-Gm-Features: AQ5f1Jrmv7KQRCuWBIo_vXTI9aIDRsZr_EQ5uQHAURWeudjXpiSlHPWiANvw4jg
Message-ID: <CAAZ8i80e6CsD1Y36-sVrVs4QPB-82J1gPOeDvHa_+sQtfUpMtQ@mail.gmail.com>
Subject: Soekris crypto 1411, where to find ?
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

hi
this is probably not the right place to ask, but I've been searching
eBay and similar places for 2 years and haven't found one yet.
I support older MIPS hardware and need to find a Soekris crypto 1411
miniPCI module or two, to add VPN acceleration.

Anyone have an idea where to buy it?

Soekris company went out of business years ago.

Let me know.
D.
