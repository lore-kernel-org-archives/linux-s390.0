Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08E296BDA
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154323; cv=none; b=bP1AmnjTYD22Kmw87f4/cX9wYMtdkPDTXuYJwYEvV9ng1uLP9j1jaY0nyREmqMdqIMI22Ffgt28caZmTDkZx0dw4C7yuBfuFEFBBnvv34G1NHcM1YKiVqXqzwttTqJS290C6+YnqMCYTDPd9wl6w3NS6T2QuV70dyhji+NbB+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154323; c=relaxed/simple;
	bh=Vm2BtOrr7/4guLkxjFZFHOZoayeqUbBXepUyeDwPM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnopVCX2NwcfBlCWTM1NmfFc+J2SrCr9Yy1smDehwDQhqEKk8UOpOZSjlkEJ9KRGTaJDBz01pPBySpNUS1dNTCEwPFk4bgfrjAoXQSoD8dT6Gosdc03DSb14cH1J6bkI2ZvPTR6E7qJtIAL5whLXbrM2IjSxFp0ZQ9QaY13XlwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5X2Smts; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5X2Smts"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-294f3105435so339135ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154321; x=1762759121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y22k5ngiq32o4MbKE/s0CLErP3q9IoFtmfwfCLBHatI=;
        b=n5X2SmtsT3C92S5w2AKKmQZO5DiAjkuCdpMd+Nh87ZsPG1CWUNv6sefJMAKMocelmE
         BztECs30WePiaiHvJqjxMx70QVB4M/C35E7KC6JNx+R0CcPhuOZlT40EAKk0I4qMBYqV
         3uea5zUH03lKRSnjWsAxHGF0UjW+MshMeMeQnJdEFTukjmhwZ7Rw3UuGlIsvx09Um7Ot
         VpxhlZWp4nMxPBVr4ie97UnuI/wgomP0P/bgDJGQws6wggZYDd3Iu3iCstm2EyxEQoxu
         rA/ECikzzGxZkz1NvA/xUWsB3bGwdXPzNCJw5Gcp9Dab1V3HbSFwV/ZMQcYuaTLyil99
         DXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154321; x=1762759121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y22k5ngiq32o4MbKE/s0CLErP3q9IoFtmfwfCLBHatI=;
        b=b0b92BZsnhqlC5EMi4gBOTXKs4Fu86+YxAFT415lT+oNhJhj+twjU0OE8uKfdLtnDh
         3s2gepHH05a1WSi6AwgY6O4s+jaubNdm5c+DDzv8Q2S7X3l3zuiEycqZC9oJPDVDwgD6
         CKmBF+Wg3wxnOayiW2ZLwukp05FBltKzdjlEGe4cQwFZdCWcQ8VRUnsPplER/rbyQqSP
         eW3ZepPM1/oiAxIipj68D1tPyRD0jAoNeGwmeUGIVPS1n5PFw1QSmlcTNMauEToxbZ8n
         pxCNiOdKvn/FhiUDD5hgB1C/aIzaUPDjmtE/kWAugsxkE7GFCmbi4N0Ti7Z08tmYTCU9
         64nw==
X-Forwarded-Encrypted: i=1; AJvYcCUcOrAc2hp++8ASyDA7LcnXLYgmx6xfK8BYHS9eavqtGGe0/f0oUAnOmh+QlQDr691DxAnx5Ys+t3Eg@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQNp1Lc9wk8/KBihLQZ6oM07hMfECVFpu0GsjKGtbQAj6f99j
	SkUhONBi7t05hqwxpMARyTI5u41poegjn8PUZb8zTK6wfjBC/l+9PRMvusm4GnqtUA==
X-Gm-Gg: ASbGncsh5jttFWya14y7UbbZ8UXdYznsmbOaRTWCeqg+Ed68buRo/31uw177sIsnOth
	qhlQm2JB4kPT2aVFKJvT1OwGY67hQ0sEfxi9zeSiSJiIyMUqnB1L2Rf565u/ODxsSYmqFcyo8uv
	GzxsP872e+lGgfcF9Uu66J3JmkZiL2a7Weq8nhx48/Y6MxvY4pksX8nLrYNY28GlKIyUv3J9kg4
	awLGXbmk9OsR6Wsvv2KIzkCce9NUgOvCybyeJGY59Pe2+L+xPBYuLNn8ZkGKS1JzhnJoJjnPB/l
	aRIvsr4lyiSu4vGITJetg51L5mu7zJC8fRsxS4+hNYVYH3oMiNedDgxwPfnOHSMj6Qkhg7FKjHl
	JVFiLiaVmhFLE3dAF7lyrjzGuENMdCgxWeDJDCuoHquHdNNJRVtHAhKa/dUytC0dqUJrMUJkHvM
	jaiSziM36+0lpjU43SN1prfdLltPePh7QqeumMvg==
X-Google-Smtp-Source: AGHT+IHz7vQ0cm4SGWCD8qu7hNB41Aed4i8aC1NkscOeFOjchnLwW8gMwvqn5xaYYumt7DzVtDnmgQ==
X-Received: by 2002:a17:902:d2d0:b0:295:30bc:458e with SMTP id d9443c01a7336-29556477728mr5855785ad.3.1762154320729;
        Sun, 02 Nov 2025 23:18:40 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197340sm10108242b3a.44.2025.11.02.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:18:40 -0800 (PST)
Date: Mon, 3 Nov 2025 07:18:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	David Airlie <airlied@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Brett Creeley <brett.creeley@amd.com>,
	dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 07/22] vfio/mdpy: Provide a get_region_info op
Message-ID: <aQhXR2M6riHmufl7@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <7-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:21PM -0300, Jason Gunthorpe wrote:
> Move it out of mdpy_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mdpy.c | 53 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

- Praan

