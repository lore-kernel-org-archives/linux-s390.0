From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 02:09:13 +0000
Subject: Re: [patch 4/4] iucv: fix cpu hotplug
Message-Id: <20090105.180913.211984504.davem@davemloft.net>
In-Reply-To: <20090105121933.936061000@linux.vnet.ibm.com>
References: <20090105121933.936061000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 05 Jan 2009 13:14:26 +0100

> If the iucv module is compiled in/loaded but no user is registered cpu
> hot remove doesn't work. Reason for that is that the iucv cpu hotplug
> notifier on CPU_DOWN_PREPARE checks if the iucv_buffer_cpumask would
> be empty after the corresponding bit would be cleared. However the bit
> was never set since iucv wasn't enable. That causes all cpu hot unplug
> operations to fail in this scenario.
> To fix this use iucv_path_table as an indicator wether iucv is enabled
> or not.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

Also applied, thanks everyone.
