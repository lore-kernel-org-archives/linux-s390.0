Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AD2309B2
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154091; cv=none; b=Ax5Wo+PNQDjZ/Me2jyzp4a+k5d4FomAidEzjSv5uZGpPvIc3+hfct/wAokPXAoKkuDiBWP+cmO0FcBLBFg1dR54jrObb6QOqRa+5+YKSYuwGxvhm+1LHwKjsgsoDpdy7rUKb3EEfic4HrVprqlg0PWieR4crw7EAevxvFbbRyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154091; c=relaxed/simple;
	bh=M46toCVjS5FqeK8M2CG3xD/T7DNTY+jrsL9mMEekFOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PInF9S1BoOd2CVooxEl+csCcOkprDsWVb6FC5ACIUCuziyuV4chHuerIpCyuzF1M3fCJYpyDW4q/cEun9wvMKNKmryZCaMYmQkCtH5OzUJZzKA4dkTT6UWnBuoN5o4W+HKLHUj/u4eiJbdTquMc4LFK2qWkAUPUYdlNsHB67kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3l0LwOAQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3l0LwOAQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2959197b68eso193285ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154090; x=1762758890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krxDO85tsubF5J6uxcbfpS+xA/eKw7o0+Vmbt9d1Ois=;
        b=3l0LwOAQyUnzNrd5Vzgo5Uey8TOYpqL56YEDPcntnKW6zOEv30BW7kUlAPg1U80xGa
         WQ/5tbrA1P7jBLezIx2eO1+Ilr9LbEIauHSWlTbNwbyvjDONd/NIkuEZbzHo0y1YItOb
         k1rygZj8tHYr07dR/n8x6NdY63FwHiMR8I97uXdHZjOirlV3K5Ywh3YSGZ4C8xLnPXes
         6e6YY5oYcXLYaajC3B5DcEtPKllYQgL4aYZJAKFd1fijWXPtpKtqePJnWErplu7zp3Zd
         BU/eCa58K7Zzpj6/O70vZwSa4GHHDqaR3YLdzxTHSsX1lC1AZYkNZ7O6LqDRofani0JX
         47nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154090; x=1762758890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krxDO85tsubF5J6uxcbfpS+xA/eKw7o0+Vmbt9d1Ois=;
        b=miRSggT5CFq05RIemPQOuHuWz7nvttncVNVXuLqpJ33JAd9rB5e6KALOfXFtlBUHqT
         oeWsNJ63PeCf4PVlC5i+nkBFSbIsDNpODMrVLTHcWz2UXlN7pgO7999d9rY+q1ztBGo4
         yF/85JwNL7+QCie9Nq62WPvB47JXLYe0I9juLcqIS0Fg5H8dQHGKLEWBTAhvIlqajrEL
         vonkUtc6k+C5MbgruxLhYT7hfyyNA8HBYOzzmm2m+IFJyPhHJEcJmNDpgUuT+dBE87De
         r9oU/mpOpmZU0+mHVvjOELNX8MXO4IL1F/32rALP/euQW5Qq4zvC4qFcr/TBe2H7nJx0
         UUlw==
X-Forwarded-Encrypted: i=1; AJvYcCWFJ9pZi8O5cH7wO+98JPVL97BoTqBT923cGzI8bK1ROYH9etI7VDIg0pEez8Z0+O9rFBBpIoJjNl2d@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaNmspVG49jXVO3P75nb9XAliTGl8OFCEeJlx4u94isSndOWw
	7dRVW8rP5PhIve5QQjguObBXM0YgdfVn2EJEgoBUndmjhHl5nUEMQkgTE6+EZ4wZlw==
X-Gm-Gg: ASbGncvymAJlpTaZzjpspt172mlQtPGEDIPLZOpMHo/F1zTDtEq+qcXLNWTcsO4OwHO
	1w5Q3UDD6W1uD3SkXtyzm3dtpwynMBJQtojKHoBygEW3rW/yW7n9/ViF+IV2hVhaJwyRmRi52uN
	8wdKrP5rPSUol5FABcEQYftJ41K100bkS01JKkfg0J65nYYBvnhH5jSuaKh35zRD0Rd9hhpjpTD
	JGCraReF9G2bKqbwHLXijAn6dy4NrJ/DjceKqCH2qzYgbTvqa0EjVFXtyhuKb5YrSB4Rb3dGIWi
	Zttc8sZqBqx3R+rDsA+/No2oWWX3Y3bmNROesUZJwLhWZCdORDMED3vWn7KquW3q58FjaCFbp9D
	bm0fLd7jn5huLUCZQD6J1XhCUq1JnAs0BSJvETRSGDewt6OvCDNx0XlOx0wRlcfKbyzerQr65aS
	k3XkyH4BoDtVL1xWjAf6dwmH9CRW4XnR42Vhux5w==
X-Google-Smtp-Source: AGHT+IE97CemVwDodrlEsACTbu3ii+CcSlX4Mt/UH1nASQkOOWezhknbfsTfFcSLebBhaZ2a41/idw==
X-Received: by 2002:a17:903:184:b0:25b:fba3:afb5 with SMTP id d9443c01a7336-295565ad1aemr5343685ad.11.1762154089465;
        Sun, 02 Nov 2025 23:14:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696eae8sm107020535ad.61.2025.11.02.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:14:48 -0800 (PST)
Date: Mon, 3 Nov 2025 07:14:38 +0000
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
Subject: Re: [PATCH 09/22] vfio/platform: Provide a get_region_info op
Message-ID: <aQhWXmluuFaU3XPL@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:23PM -0300, Jason Gunthorpe wrote:
> Move it out of vfio_platform_ioctl() and re-indent it. Add it to all
> platform drivers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  1 +
>  drivers/vfio/platform/vfio_platform.c         |  1 +
>  drivers/vfio/platform/vfio_platform_common.c  | 50 +++++++++++--------
>  drivers/vfio/platform/vfio_platform_private.h |  2 +
>  4 files changed, 32 insertions(+), 22 deletions(-)
> 

Moving the GET_REGION_INFO logic to vfio_platform_common.c and exporting
it for both the vfio-amba and vfio-platform drivers to use in the new op
looks correct. LGTM

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
