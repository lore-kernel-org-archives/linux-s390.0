Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE3EEA9;
	Sat, 18 Jan 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737213912; cv=none; b=jExmAalAMLajG/99P0bhP9kk9lVNtrJaTyByKiUspC4se+JEAqRYTf6ehjiAg+9yjpO3GksRjoizKaVoXC8KgE+xr69QGUPHHzF/mnAFc38fEdZxvTO7VXm9wWjAMgJwf+a2rrhmIGt/gE27W3I9fYBJGuI72Gx5SOjJXvy+kV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737213912; c=relaxed/simple;
	bh=fz7baTqM06vt93i5MvvQHAb1+7YvpwDZ70FEN+OQqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guQrXFdaXOMiDWn1P3ZaMa0NrhmyuIkRoR0FwsZQbKo/2YPNs4TSdjkGFjZMH1K9Oa22xKiIyN/GODchidXIxfGSf5ZeOJGm6wDiTA5B9I8tP3eHMXgEUxbHml6deGXaEP0vKKNssik0e9zYFeBeNvPcYErA37pCyZuQVyrDn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eek92nyI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eek92nyI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737213900; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+akNXEPMRX6GUssnkzMA71VABTjMj72/n1h8TJMC17s=;
	b=eek92nyIj49rIKMbbEN+qjYMPQDznbGNOjbZyLj+YEMlAIn7ECqCNS0piuW+XEn2yCdB11IixkbVxgnnmzkOLfCjP+OS7qEpaPlFCVmap7NMusDksGl/DjQgD3/P+ADrwJG2tmZpo9a1WGqEl5+qwuzujquBBwjUlKJyoflxVxI=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNrf1Ii_1737213899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Jan 2025 23:25:00 +0800
Date: Sat, 18 Jan 2025 23:24:59 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250118152459.GH89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <235f4580-a062-4789-a598-ea54d13504bb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235f4580-a062-4789-a598-ea54d13504bb@linux.ibm.com>

On 2025-01-17 12:04:06, Alexandra Winter wrote:
>I hit the send button to early, sorry about that. 
>Let me comment on the other proposals from Dust Li as well.
>
>On 16.01.25 10:32, Dust Li wrote:
>> Abstraction of ISM Device Details: I propose we abstract the ISM device
>> details by providing SMC with helper functions. These functions could
>> encapsulate ism->ops, making the implementation cleaner and more
>> intuitive. 
>
>
>Maybe I misunderstand what you mean by helper functions..
>Why would you encapsulate ism->ops functions in another set of wrappers?
>I was happy to remove the helper functions in 2/7 and 7/7.

What I mean is similar to how IB handles it in include/rdma/ib_verbs.h.
A good example is ib_post_send or ibv_post_send in user space:

```c
static inline int ib_post_send(struct ib_qp *qp,
                               const struct ib_send_wr *send_wr,
                               const struct ib_send_wr **bad_send_wr)
{
        const struct ib_send_wr *dummy;

        return qp->device->ops.post_send(qp, send_wr, bad_send_wr ? : &dummy);
}
```

By following this approach, we can "hide" all the implementations behind
ism_xxx. Our users (SMC) should only interact with these APIs. The ism->ops
would then be used by our device implementers (vISM, loopback, etc.). This
would help make the layers clearer, which is the same approach IB takes.

The layout would somehow like this:

| -------------------- |-----------------------------|
|  ism_register_dmb()  |                             |
|  ism_move_data()     | <---  API for our users     |
|  ism_xxx() ...       |                             |
| -------------------- |-----------------------------|
|   ism_device_ops     | <---for our implementers    |
|                      |    (PCI-ISM/loopback, etc)  |
|----------------------|-----------------------------|


>
>
>This way, the struct ism_device would mainly serve its
>> implementers, while the upper helper functions offer a streamlined
>> interface for SMC.
>
>
>I was actually also wondering, whether the clients should access ism_device
>at all. Or whether they should only use the ism_ops.

I believe the client should only pass an ism_dev pointer to the ism_xxx()
helper functions. They should never directly access any of the fields inside
the ism_dev.


>I can give that a try in the next version. I think this RFC almost there already.
>The clients would still need to pass a poitner to ism_dev as a parameter.
>
>
>> Structuring and Naming: I recommend embedding the structure of ism_ops
>> directly within ism_dev rather than using a pointer. 
>
>
>I think it is a common method to have the const struct xy_ops in the device driver code
>and then use pointer to register the device with an upper layer.

Right, If we have many ism_devs for each one ISM type, then using pointer
should save us some memory.

>What would be the benefit of duplicating that struct in every ism_dev?

The main benefit of embedding ism_device_ops within ism_dev is that it
reduces the dereferencing of an extra pointer. We already have too many
dereference in the datapath, it is not good for performance :(

For example:

rc = smcd->ism->ops->move_data(smcd->ism, dmb_tok, idx, sf, offset,
                               data, len);

Best regards,
Dust

