From: Jeff Liu <jeff.liu@oracle.com>
Date: Wed, 18 Jun 2014 01:47:24 +0000
Subject: Re: [PATCH 14/24] drivers/s390: return actual error on sysfs init functions
Message-Id: <53A0EFAC.5040807@oracle.com>
In-Reply-To: <53A05178.7010004@oracle.com>
References: <53A05178.7010004@oracle.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

On 06/17/2014 22:32 PM, Jeff Liu wrote:
> From: Jie Liu <jeff.liu@oracle.com>
> 
> Return the actual error code if call kset_create_and_add() failed
> at drivers/s390 subsystems.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Jie Liu <jeff.liu@oracle.com>

Please ignore this patch because Greg think that is incorrect.


Cheers,
-Jeff
