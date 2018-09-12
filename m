From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Sep 2018 14:59:20 +0000
Subject: Re: [PATCH 2/2] s390: qeth: Avoid unneeded command name lookup
Message-Id: <1536764360.18788.19.camel@suse.de>
In-Reply-To: <65861df5-afbe-e8b4-ea6e-37c12d6c2301@linux.ibm.com>
References: <65861df5-afbe-e8b4-ea6e-37c12d6c2301@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Julian,

On Wed, 2018-09-12 at 16:50 +0200, Julian Wiedmann wrote:
> Thanks Jean, but I'd rather pass on this one. I don't see an improvement
> in readability, and performance just isn't a concern for this specific
> path... there's hardly any traffic on the interface's control plane.

Sure, you will know better. The initial optimization of
qeth_get_ipa_msg() and qeth_get_ipa_cmd_name() made me wonder if maybe
performance was considered important on these paths, and this is why I
wanted to pay attention that my changes would not cause a performance
regression. If there is no such concern then all is well and this
second patch is indeed not needed.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
