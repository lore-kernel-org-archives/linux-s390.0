From: Stefan Haberland <sth@linux.ibm.com>
Date: Tue, 23 Oct 2018 14:57:46 +0000
Subject: Re: [bug report] [S390] dasd: security and PSF update patch for EMC CKD ioctl
Message-Id: <9a4eee04-4763-cf26-652d-b8be03ae743e@linux.ibm.com>
In-Reply-To: <20181017120312.2xxw7aynoiorqjxx@kili.mountain>
References: <20181017120312.2xxw7aynoiorqjxx@kili.mountain>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17.10.18 14:03, Dan Carpenter wrote:
> Hello S390 devs,
>
> This is ancient, and CAP_SYSADMIN but it's probably simple to fix.
>
> The patch 52898025cf7d: "[S390] dasd: security and PSF update patch
> for EMC CKD ioctl" from Mar 8, 2010, leads to the following static
> checker warning:
>
>

Hi,

thanks for reporting this. I will have a look.

Regards,
Stefan
