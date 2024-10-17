Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098261DE2D7;
	Thu, 17 Oct 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174008; cv=none; b=qKdZ2Avwp7X5D9Gd5p+D+Sbol+Gxut/08BGqvOvebW/kmzoiVNkqzDdbFu/gT0L65IJiq9ysGmIzI1BKgOU+MlzRXct1ewRKhi71ftIioT59i/xllXc1QxPr9wOUV3KJQ7atqWIS+xx8KCX4ztJRPh8SxD6NTFwIfA02hCGrDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174008; c=relaxed/simple;
	bh=WX1AoS3d5If/wj1YU6S8DtGrKd076jNdTMfVeiprVUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZghoP2ANfYvX9MhlgVz5InFXWzBQuG2ajn78LYkUwW968ZCTLwb3YctPkbkzO7lUVt9jrAH/8SuxGnXaEOfuNARcGC0EloQcswlSz/IeqZP2/qgahZaRhjB719FTYleyQkz5WGFrcwJawaqCEu8+UiNOt6BmTr/jJHPNjMj21bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juMTZLP0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juMTZLP0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208cf673b8dso10705875ad.3;
        Thu, 17 Oct 2024 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729174005; x=1729778805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gQdWouXs827SNDWHd0ds2A8+zPo3SHvKW2FhzP8Dss=;
        b=juMTZLP02edC7yFMl/ZFCCiw0A1k/if9FDx0fzTkhBcq+p2FRh388F3edVDFKbulZO
         cViWc2uTXkcAkFxDNNSPYZq0llgy4Q+wqbLdMzJZOH7FRCfHN+Rv8ccOHmnc4CO10DXf
         oTjymzqSTGsEIL0OJKW7RJNfGQoLkg5WnxcdnxO6vq3o5L1MKL33442VfFmB0gldHGjU
         u0f5YNVSzt/R4PeRzwNXh69X/OhGv2TdmlVkgrbHi/NKo6oaqYcu/xjF86kFN0fKb3dq
         8gnhPHm6P4J/OAGnFO2e3Uuvk4vv72PpQUHLJOcdXcoAJ3g0v3pNKmRf9GiAqJNrJIwp
         KgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174005; x=1729778805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gQdWouXs827SNDWHd0ds2A8+zPo3SHvKW2FhzP8Dss=;
        b=Z++c2lSW9sSX97Yr7BV5OwTmsNPNGiEnSDHgfHg6J6Psny1W9velx2RmrfWAFkxXpi
         IQZh7hCeQXxlGKBbp1Mh2E45jkpWBmkXyNv+gyz+GGyeJBfGTNkO4zulvkb4vs9U6PBV
         M9BR4dw8Sr7KIOlTaRATK8fn3mMqdtcvTmJ57LZ4kj85LYjXkK22jK39SuoKxMVb7GHa
         1sQPkznubjCZJyOcI+jnLFwbSMsvGRIuejMJKMKg1VsN4gatE1hxBnIkZQFrM5x4gxCD
         L6rRBodqxvOEhf004sakmPiJ34DpQlhnzPgjMb5X16y+uDefw9DUxRfq47Tv+5QMbWp+
         Ny8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeeTN3TZe0J8YWpwS6U8Uw0QehdIupSEJJ48IgM7wqqao15WsT4BCzj2R9GzaUeVmZVpZY5r2P@vger.kernel.org, AJvYcCUfCEXcIGeyrdRgMhjYArdaiQRMdKkmjNK4apkB2hUViszAthEi9NOuAmptVeDpG6FF2rxEc+Ji0UcESD8=@vger.kernel.org, AJvYcCUiCRIVWuBN7b2wxW29ue1pDq84aMblM2bLW3YYRxYmjftgP2TzfsapdK1muxJ9w/R7tJFg2688fHzPzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznovT8zRGHhBOywjC2sgGK2/ZRH4Gi6e4JGrNBrMoO9qxO0zNt
	p9RbinNbNQ6JlkJ279bQU9HzkShaVKgT4PytGIIUfQ2CtD7d9b7Adn0RpYWv
X-Google-Smtp-Source: AGHT+IGSc2kVhRP9r0cXbDlgeaG302x+d6kUWor6x8foYTNrGEaT9uZnOKGyAbkXPfOfqnyPxksO/Q==
X-Received: by 2002:a17:902:ce8f:b0:20c:9c09:8280 with SMTP id d9443c01a7336-20d27f404admr123437015ad.54.1729174005288;
        Thu, 17 Oct 2024 07:06:45 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm44933655ad.182.2024.10.17.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:06:44 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:06:42 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PtP driver for s390 clocks
Message-ID: <ZxEZ8n23MIc0tv5K@hoboy.vegasvil.org>
References: <20241017060749.3893793-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017060749.3893793-1-svens@linux.ibm.com>

On Thu, Oct 17, 2024 at 08:07:47AM +0200, Sven Schnelle wrote:
> Hi,
> 
> these patches add support for using the s390 physical and TOD clock as ptp
> clock. To do so, the first patch adds a clock id to the s390 TOD clock,
> while the second patch adds the PtP driver itself.

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>
