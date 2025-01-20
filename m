Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600615575C;
	Mon, 20 Jan 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393507; cv=none; b=hPl5RIk25aZb/V32tQVmMX/YFF8vyWu8TRIqziOPXHBsdGxkP4JXabIwM+aJPvlUufhpFypVvp8O0sdfIoKVuFD93MP1RYWdzn2y7pFgRF1HFunuQTJyF3UpHkdWAPGnna28i8Gk4+JED2+vCAHj9eGhddmX3lX+6YLrLpLsTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393507; c=relaxed/simple;
	bh=gZrH04UrX1WzhsZDJ37CiKj8KVsDcg7H2g4hjNtlYew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ0JxqRjFlv4rBUGxtMxuqnq82fK+spGuA8t/lITGg69mJBVwKkHdesSdNPAFNTmlwaXIYNkqHCceCEEZl1glIJ9PbyTF/pA/+2fSZQJe6uqjIZFIwb5c23XPBCnxt/rmxKtuFsyyZLGwqPcJSTNti6VTNjc15LlRNLUNQlGgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmS/AmZ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmS/AmZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511C2C4CEDD;
	Mon, 20 Jan 2025 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737393506;
	bh=gZrH04UrX1WzhsZDJ37CiKj8KVsDcg7H2g4hjNtlYew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmS/AmZ/XZiYmDkFCc3bvJ2XzG3ZC6buxBF6j8Znwaw8k3LcUrpv1LJKhZ8SSb8Ch
	 EIiC6VgjwJCFOtb80cwW35+Sp6Rfk49xw/XoZmXFg0kbVH2Vv1MTFtzMZrqXYprogk
	 WIQfkiHZCK73OFWMi+32le76O/yOwXeqlwHzN7CFmSoz9dEkaVlc80yvSNO0ghf5jB
	 odCCvUoOU8UkU73zKjzd8e7csaQ+BHg29/+5g11BbN+5f/KxmOvUWtWEFdJGnEEiRW
	 dz03F3ymb6OHIID/zMaxW1uHzOzS3mMK2jZOWHikZ59M4yrerxwr6cByj7px5VRSvX
	 PQAZxH16AgK6A==
Date: Mon, 20 Jan 2025 17:18:20 +0000
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Julian Ruess <julianr@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC net-next 3/7] net/ism: Use uuid_t for ISM GID
Message-ID: <20250120171820.GC6206@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-4-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115195527.2094320-4-wintera@linux.ibm.com>

On Wed, Jan 15, 2025 at 08:55:23PM +0100, Alexandra Winter wrote:
> SMC uses 64 Bit and 128 Bit Global Identifiers (GIDs)
> that need to be sent via the SMC protocol.
> When integers are used network endianness and host endianness
> need to be considered.
> 
> Avoid this in the ISM layer by using uuid_t byte arrays.
> Follow on patches could do the same change for SMC, for now
> conversion helper functions are introduced.
> 
> ISM-vPCI devices provide 64 Bit GIDs. Map them to ISM uuid_t GIDs
> like this:
>  _________________________________________
> | 64 Bit ISM-vPCI GID | 00000000_00000000 |
>  -----------------------------------------
> If interpreted as UUID, this would be interpreted as th UIID variant,
> that is reserved for NCS backward compatibility. So it will not collide
> with UUIDs that were generated according to the standard.
> 
> Future ISM devices, shall use real UUIDs as 128 Bit GIDs.
> 
> Note:
> - In this RFC patch smcd_gid is now moved back to smc.h,
>   future patchset should avoid that.
> - ism_dmb and ism_event structs still contain 64 Bit rgid and info
>   fields. A future patch could change them to uuid_t gids. This
>   does not break anything, because ism_loopback does not use them.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

...

> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 6763133dd8d0..d041e5a7c459 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -12,6 +12,7 @@
>  #include <linux/uio.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/ism.h>
>  
>  #include "smc.h"
>  
> @@ -94,4 +95,24 @@ static inline bool smc_ism_is_loopback(struct smcd_dev *smcd)
>  	return (smcd->ops->get_chid(smcd) == 0xFFFF);
>  }
>  
> +static inline void copy_to_smcdgid(struct smcd_gid *sgid, uuid_t *igid)
> +{
> +	__be64 temp;
> +
> +	memcpy(&temp, igid, sizeof(sgid->gid));
> +	sgid->gid = ntohll(temp);
> +	memcpy(&temp, igid + sizeof(sgid->gid), sizeof(sgid->gid_ext));

Hi Alexandra,

The stride of the pointer arithmetic is the width of igid
so this write will be at an offset of:

   sizeof(igid) + sizeof(sgid->gid) = 128 bytes

Which is beyond the end of *igid.

I think the desired operation is to write at an offset of 8 bytes, so
perhaps this is a way to achieve that, as the bi field is a
16 byte array of u8:

	memcpy(&temp, igid->b + sizeof(sgid->gid), sizeof(sgid->gid_ext));


Flagged by W=1 builds with gcc-14 and clang-19, and by Smatch.

> +	sgid->gid_ext = ntohll(temp);
> +}
> +
> +static inline void copy_to_ismgid(uuid_t *igid, struct smcd_gid *sgid)
> +{
> +	__be64 temp;
> +
> +	temp = htonll(sgid->gid);
> +	memcpy(igid, &temp, sizeof(sgid->gid));
> +	temp = htonll(sgid->gid_ext);
> +	memcpy(igid + sizeof(sgid->gid), &temp, sizeof(sgid->gid_ext));

I believe there is a similar problem here too.

> +}
> +
>  #endif
> -- 
> 2.45.2
> 
