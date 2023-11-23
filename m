Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dp3Pv+Rb"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163D10C1
	for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 11:43:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c48fad2f6dso206939b3a.0
        for <linux-s390@vger.kernel.org>; Thu, 23 Nov 2023 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700768610; x=1701373410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpkzZHg09ad7VkHOnG/quo/T41ONjJ1411UTG4haLXU=;
        b=dp3Pv+RbN7GZ2lrzjUffbQSF0LOT7BAeVxL6NUaQWXL7BGCA8WDsDwdIv1vBi/bJh+
         x+kueLLHCLnZJPbC862Wr+FeUwslFH4KsQDxtO27+z0Knohfoc1/nZaiTZIc1t1+Rm5F
         bvX5ONi4yF1JFQpbP3Y8QFG7vPyFuxrLoF8RUWAS0rpopJh1ZZOocP0Uy5U4Mbs71JTW
         VqkNsfgKvCuwd0Zp3UY9OofwAtmwZAmjrrLLpSdFn8xdFL18Apgz7eraE8iP8965BEqc
         m07TYmEVY2jR+/GcdHXejKJSgc79oFbqpKjLmiJQ2p1a0vrTf4zkItE1lOEdMbMyzUCQ
         ca8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768610; x=1701373410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpkzZHg09ad7VkHOnG/quo/T41ONjJ1411UTG4haLXU=;
        b=v+wrqRAMvtGQhX6Eljlk/bl94sXf5NYTryMTZ2qK1YDcGxZ/jsyenCmHg+TGLCdby4
         XSN5bqC7uYIo89BSajWsU5ZTT0IR7oIq2tiG20EDrh08rsqTxhkfqIQiKh3ChU/xhomb
         c+/HmsNJ9PMgDos7IxGjJWbMX13bitVmXW93tGgj6pQyqvzNgYPEeU4I20zh3xBBd3DG
         qh3dd//s5yXMw24SlRxHOTe9UFuFc6FVWcTpg2AyaZMSTVF+Ukk2yQJUXCwLXk3Xs5sQ
         zb4xEOo60CpTqepna/mRyPRVkmuhkC6Zr5+8918xLaDw1j1ij9olK+u7u8EhOZhUAeql
         ugww==
X-Gm-Message-State: AOJu0Yy/s8wbK5viPpR36PbOlGN13kcghMTT0vnO+9J6aiMfnZ2H1kYt
	ltclDoTrSFN9HHXRiCY3Q5ZFuA==
X-Google-Smtp-Source: AGHT+IEPG4J941SLrpY4uC/ri/G2ja2akCNdtY4pHEKeo+HpcNnwpEYC41wSse9D2H40uEI86qohgw==
X-Received: by 2002:a05:6a00:9381:b0:6bc:ff89:a2fc with SMTP id ka1-20020a056a00938100b006bcff89a2fcmr544106pfb.2.1700768610318;
        Thu, 23 Nov 2023 11:43:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b006cb65cfde6dsm1567524pfu.200.2023.11.23.11.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 11:43:29 -0800 (PST)
Message-ID: <cb41cf91-1c75-4edc-b00f-59763344b15c@kernel.dk>
Date: Thu, 23 Nov 2023 12:43:23 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] eventfd: simplify signal helpers
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Oded Gabbay <ogabbay@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan
 <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>,
 Benjamin LaHaise <bcrl@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
 Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fpga@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-aio@kvack.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 5:48 AM, Christian Brauner wrote:
> Hey everyone,
> 
> This simplifies the eventfd_signal() and eventfd_signal_mask() helpers
> significantly. They can be made void and not take any unnecessary
> arguments.
> 
> I've added a few more simplifications based on Sean's suggestion.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Changes in v2:
> - further simplify helpers
> - Link to v1: https://lore.kernel.org/r/20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org

Only oddity I spotted was the kerneldoc, which someone else already
brought up.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

