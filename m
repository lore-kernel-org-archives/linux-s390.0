From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 05 Jan 2009 12:14:22 +0000
Subject: [patch 0/4] iucv patches for net-2.6.29
Message-Id: <20090105121422.994795000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

the following 3 af_iucv patches and 1 iucv patch are intended for 2.6.29.
They contain:
- af_iucv: detailled error handling for iucv_path_connect
- af_iucv: cleanup improvement after connect failures
- af_iucv: cleanup improvements in connection-requested callback
- iucv:    fix cpu hotplug for compiled in / loaded, but unused iucv.

Thanks and regards, Ursula
