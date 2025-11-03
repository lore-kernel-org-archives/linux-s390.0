Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545F2E8B6C
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165553; cv=none; b=W13MGX1B4Co+nDV5k2NgO3gbr5ExDbJFby/fiypSAGhW9V7hPzRWETrVmefuZFdPhmrptau5FLL6OUOjIFnPk3+DDkE7cXZ+X43DBzlHQeLaEhqIKAgEgpEG/7Q4AexFZiJrNVJGkzeL9nVQ2qMIPbVkwrC3B/FocIohFN6cMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165553; c=relaxed/simple;
	bh=xb3/uOBbnH/5IyfGrBW3QoHg6qdVt4MgJ44IyIy3YbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axMIgJ1dIyZUHM4YOYdFM3985nOdXG+8HLLSXjgwHjn4lMzhzGZtLHL2oYVncvQLY25DSG6Jnsc5hGEPyf+4al9pNdb0xvvyEtRgO/T/adQ0RBIEO6sGNnYtgm/kPfkRresMjkF30CjDTlEkTGjFum5/MdTo6lqliNEgXu3zTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqClDDvk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqClDDvk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2959197b68eso230425ad.1
        for <linux-s390@vger.kernel.org>; Mon, 03 Nov 2025 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165551; x=1762770351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gv2e9ygsp9GWwcHVuU/GyMuAUbYvn3xLnsbOpkJhe98=;
        b=pqClDDvkyzNdlSQ2BdQE6uGfbrFiwztCuZrUDk1YlJ9J5t+EjK6mi265sU3nKSTq6U
         nS0gu2s5gIX0WtlXLh7fWwOJYEFolbkpAVq7qmuRoFgl5NspyesbKEXQ+Zz96kTX92xU
         /wTJVLBRxeBkfoJjuKn21ZJwS/tuJg6Zc+8S2M46E0K9tJxM+soEDR0m7srCmmD/wzPk
         8tP8M2aYGvUqx2BY3kGBc29H9gr+Rgp5lvC6MQH09nUj+Tuv8Jjd2Z6+DxaXy4MFPim0
         vto0l2gCCy3e2nGzlmIlRf5lEvQWQAY9YsA/mwbtuJOeLp2vsqVCc6rUplSisyFN4rdI
         oa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165551; x=1762770351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv2e9ygsp9GWwcHVuU/GyMuAUbYvn3xLnsbOpkJhe98=;
        b=jen4N8lBGisCLcVN29Cel+JnZ71V9FRoMSWqXlBcmab0fj3G5mZJUXRKLGmsPIRs2m
         tEIvAgKTfBRJscqze8R2qVOFHU+QCHih7As7Yk1SSBhJs9kJ0yDewQ6fLovsWuWiuPGg
         rz3KgspfPTvPhAL/QYDcpbhlQlVCRQHFQO36SclyT1ek2IkiP9jpKiXu0F5afaVBEwHz
         pkn0WvSzNH9nFn5U9xmTOj7WCoKeT1nKYMDJC/EdMs2ZcUhTQMOAQaB42BNMxfyUrEgC
         U1gtkHSx7kDnLUHSDn4YyhgIKFgq3Q324g98RJwkzBJZ0nFGNHgNf35tmLVT4l+zwdM0
         8h6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHmWp9czCTJV/JK09wQg/HwX3Cdb1xJfbzMURUfYTzvtzDxeeyt0nFrCoClGASz0LymCgBas8xH1YQ@vger.kernel.org
X-Gm-Message-State: AOJu0YztR6qiiEp89p9HSHEfs5IlG5NGNoosIEBRbwW0uTVyq8cyo8bE
	o2itJmpeqwEJCprJgtDWMcV1iM+1KZYukfzvEQDYYEKdc/Mulwx3t2LKU1TaCNZcDQ==
X-Gm-Gg: ASbGncuiEUKRoBNeP4CwC3LR1BKjbsU/zWiqXKUT1gnNzrINduIh8nc+IRleV00huG2
	rJ5GtZMTo9zHunkM5muYbTDM0UG9Gb1VdrX09ZfT5ReZFzduZlBF09iPtepIZjWs2q8qolidXZu
	xIoE8AULZH8jQGHYV+SCrWCr4vNN80PAmoKFRrLvNCPtxENtcuEVExD1G0KtOxlStSqNzSXHW0K
	3LAy+kcsKHIJdATQeMYS8Gq85c76Z4VEwxQvPCWh35D6A+/0+o+3f1PSTm3zGztbsSv118RXSSY
	OaGXFYYPvxbuc28UnOn/sizgyr719o+SMEnoNzIF0ylklaUDvAH8Tr3UHyCTYeVN6uyYT0neyiu
	Fosk/AzO09niuLlS3MRIiDoLZZTmF4c1NWCUkdrsorb7b0KA37UIFSfaC/z+cU/5ETAlcDeu1HM
	YS1qF6oi/Shq2krkHUr/dTeQiPpbD+H41+Y6ON0A==
X-Google-Smtp-Source: AGHT+IGWMvk41x0fPTVw6ZYdCrfpoxx7g/UVoBFTBuqaFXqto2Ol7yP/kHVO5kf2HNRBirU7N6KCng==
X-Received: by 2002:a17:903:41c8:b0:294:ecba:c8e with SMTP id d9443c01a7336-2955658e7b9mr5841305ad.3.1762165550799;
        Mon, 03 Nov 2025 02:25:50 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm3684424a12.17.2025.11.03.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:25:50 -0800 (PST)
Date: Mon, 3 Nov 2025 10:25:40 +0000
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
Subject: Re: [PATCH 19/22] vfio/pci: Convert all PCI drivers to
 get_region_info_caps
Message-ID: <aQiDJDdJGigjtkeU@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <19-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:33PM -0300, Jason Gunthorpe wrote:
> Since the core function signature changes it has to flow up to all
> drivers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  30 ++---
>  drivers/vfio/pci/mlx5/main.c                  |   2 +-
>  drivers/vfio/pci/nvgrace-gpu/main.c           |  51 ++-------
>  drivers/vfio/pci/pds/vfio_dev.c               |   2 +-
>  drivers/vfio/pci/qat/main.c                   |   2 +-
>  drivers/vfio/pci/vfio_pci.c                   |   2 +-
>  drivers/vfio/pci/vfio_pci_core.c              | 103 +++++++-----------
>  drivers/vfio/pci/virtio/common.h              |   3 +-
>  drivers/vfio/pci/virtio/legacy_io.c           |  26 ++---
>  drivers/vfio/pci/virtio/main.c                |   6 +-
>  include/linux/vfio_pci_core.h                 |   3 +-
>  11 files changed, 80 insertions(+), 150 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
