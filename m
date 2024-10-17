Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB21DDC3C;
	Thu, 17 Oct 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173977; cv=none; b=D3nWGx/BRPMnCIhHSjVSh+0NiZ1WRwYWIl9G1Axs24QhtWS7EHaNnfaXctTr0EhyZLAcxORTfyy/hV5Q8KVAQdO9uTv7vFK9Ahfc+pfTLVG7pWjUAvt+vhyjqe9ZRFzZwLKRn3NTF1QCV3D81xAVR/cvJnnagRjWk/fEqR5P5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173977; c=relaxed/simple;
	bh=w9wJTWU2a5qVi7Mhg5hkYv7mEL5zyvHWEPt9bZTl71w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYOKe9r7nSDGhKpeHkFIV5X0WtQHutpGMilwdt9EwT+z+7gjTlgzLlcG96za3bHJbJ8nWuoICFozLP97n0Bs3tY1O90qiJ0/UwlqETKfI8QMiH8fGXMVw47VzP0zRxxl/5yFJBG3deL3cIJV4Hw2bf7ngm0t4CChXetPftbCDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y87UXVyc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y87UXVyc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so519942a12.1;
        Thu, 17 Oct 2024 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729173975; x=1729778775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9wJTWU2a5qVi7Mhg5hkYv7mEL5zyvHWEPt9bZTl71w=;
        b=Y87UXVyc2T/xENjTXK5Z1tONuwv8enEzlXazSq6d6l+mbIxnKqRGryyNanAwYVAivZ
         TaVDDc1Vh9df7S9QUeykRQwOL6WE3T32PNXKqMI/ytdCiBnf2fcfY0CGRCtFdsHunHLm
         w6VTThJAhRWBt5rEgzeNMxEBebXoFK92Jw+WOdA2v2AAJ+CoDUjitEKx3J3O4eKm+NXf
         tuboxu3I1rznDGReHTA5ZQxqT9SVuRpwABxLLDQzVNbQ5iUDzZitloRg9yGoAbZxFJYK
         5IUvYtOaTUtLjqFzkUOxkPqGzl8t9HzfH+iGModocGPD8Sds6A5gROjlXU97Cq6raVva
         U0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173975; x=1729778775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9wJTWU2a5qVi7Mhg5hkYv7mEL5zyvHWEPt9bZTl71w=;
        b=OtiPPazlHaijZwpZ5hAcCc5SxTxK57XzKpnx4SNkay1QEUCJ6br1WVNMktwDY4ifeO
         EFwdLIu+LhseR71gl2v4I+Hi7HCOhMUp4gGqL3YWEBb36hB8UojTKZBqCP8nYURHP53M
         g4bvaRRKSyc3dgxsveVM4XGOlL+Z9PxFud0mybbLPNEgo2kHWZ0RCTksLW18mz3tUy/q
         w7qfn78sRNcWmXWuwcA4oqAKh7AxTF9GsEeAmIqILUSN+UeUNsKpzEbqUZCqd9vddwK5
         rvzRVk4uFiWoqX8AgKEm5yp9kCn5LA75eNx2pKE3aQa4izgk+fj70wh4KsulA2sbv9er
         h19w==
X-Forwarded-Encrypted: i=1; AJvYcCW9gxGHMgSiYb9oVVwX6L3FJH/Zq2fpGLOiNKlrj7ifw0/ag6KT9cuSvhSv4f/JO06gM1XX0U6zmIBM0A==@vger.kernel.org, AJvYcCWCBTwQRXCspNHrxZ67+1uLY/+FzJEAvbIJLlVEJDvWQPBshUzQUZEJgXqsDviFbQYJdksOwlzXNbyMYpY=@vger.kernel.org, AJvYcCXtJZjWNPUT5IoAFbOY1/XiK07Z6zec2XRep7hNViF1zpV7NagUDuOJjilgLfL6actVsw+AQPrD@vger.kernel.org
X-Gm-Message-State: AOJu0YwszdtE4me4srBUoV39+JkxOhHkiB4ZuBnw2fgfczkoOGchIr/8
	K/hwqp//oLW8xNrnmZ5+2u1dnOQ3c1BI/CFtcEIrFe+G4S4npciu5moMqCX3
X-Google-Smtp-Source: AGHT+IFh1CyapyiDDJnauYK+23Jv5vxqqLi47WppR37qF6Q6jcd8Zk7CmGwlKhUYcNIPLdCWCMSelw==
X-Received: by 2002:a05:6a21:1693:b0:1d9:252f:a074 with SMTP id adf61e73a8af0-1d9252fa20emr1719508637.22.1729173975024;
        Thu, 17 Oct 2024 07:06:15 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370dccsm4930396b3a.18.2024.10.17.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:06:14 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:06:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PtP driver for s390 clocks
Message-ID: <ZxEZ1G-p5jfxQK7n@hoboy.vegasvil.org>
References: <20241017060749.3893793-1-svens@linux.ibm.com>
 <20241017094606.6757-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017094606.6757-A-hca@linux.ibm.com>

On Thu, Oct 17, 2024 at 11:46:06AM +0200, Heiko Carstens wrote:

> Richard, if this looks good for you too, how should this go upstream?
> We could carry this via the s390 tree, if you want.

PTP drivers normally go through net-next.

Thanks,
Richard
