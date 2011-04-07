From: Alexander Graf <agraf@suse.de>
Date: Thu, 07 Apr 2011 08:47:30 +0000
Subject: Re: [PATCH] s390x: Add force flag for dasd style partition label detection
Message-Id: <306D9D75-78ED-4CDD-B5E0-BF97DEC9A133@suse.de>
In-Reply-To: <4D9C7B5A.6070201@de.ibm.com>
References: <4D9C7B5A.6070201@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 06.04.2011, at 16:40, Carsten Otte wrote:

> On 06.04.2011 15:06, Alexander Graf wrote:
>> Could you please tell me some way to format a dasd device so that it has a blocks/track value different from 12? Also, do people actually do this?
> That's easy: use a different blocksize than 4096 bytes with dasdfmt.

Ah, I see. Do people do that?

Also, we could just pass the geometry to the force functions as well. That way we could convert things on the fly and keep everything dynamic.

I assume the best approach here would be to specify the blocksize rather than blocks/track value in the command line, as that's what users remember (at least me). What's the correlation between blocks/track and blocksize? Is it just blocks/track * 341? Or is it 1 << blocks/track?


Alex
