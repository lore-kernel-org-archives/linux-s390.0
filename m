Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64199 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726503AbgETFZR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 May 2020 01:25:17 -0400
Subject: Re: [PATCH] s390/sclp_vt220: Fix console name to match device
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <65218cdb-d03f-29a8-1e78-42ff2d4f958d@de.ibm.com>
Date: Wed, 20 May 2020 07:25:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Valentin Vidic <vvidic@valentin-vidic.from.hr>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org


On 19.05.20 20:16, Valentin Vidic wrote:
> Console name reported in /proc/consoles:
> 
>   ttyS1                -W- (EC p  )    4:65
> 
> does not match device name:
> 
>   crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0
> 
> so debian-installer gets confused and fails to start.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> Cc: stable@vger.kernel.org

This is not as simple. ttyS1 is the the console name and ttysclp0 is the tty name.
This has mostly historic reasons and it obviously causes problems.
But there is  documentation out that that actually describes the use of 
console=ttyS1 console=ttyS0.
to have console output on both sclp consoles and there are probably scripts
using ttyS1.

I am wondering. The tty for ttyS0 is named sclp_line0. Does this work in LPAR?


> ---
>  drivers/s390/char/sclp_vt220.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
> index 3f9a6ef650fa..3c2ed6d01387 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c
> @@ -35,8 +35,8 @@
>  #define SCLP_VT220_MINOR		65
>  #define SCLP_VT220_DRIVER_NAME		"sclp_vt220"
>  #define SCLP_VT220_DEVICE_NAME		"ttysclp"
> -#define SCLP_VT220_CONSOLE_NAME		"ttyS"
> -#define SCLP_VT220_CONSOLE_INDEX	1	/* console=ttyS1 */
> +#define SCLP_VT220_CONSOLE_NAME		"ttysclp"
> +#define SCLP_VT220_CONSOLE_INDEX	0	/* console=ttysclp0 */
>  
>  /* Representation of a single write request */
>  struct sclp_vt220_request {
> 
