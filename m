Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 7/7] s390/cio: Remove vfio-ccw checks of command codes
References: <20190503134912.39756-1-farman@linux.ibm.com>
 <20190503134912.39756-8-farman@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 6 May 2019 14:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190503134912.39756-8-farman@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8625f759-0a2d-09af-c8b5-5b312d854ba1@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2019 15:49, Eric Farman wrote:
> If the CCW being processed is a No-Operation, then by definition no
> data is being transferred.  Let's fold those checks into the normal
> CCW processors, rather than skipping out early.
> 
> Likewise, if the CCW being processed is a "test" (an invented
> definition to simply mean it ends in a zero), let's permit that to go
> through to the hardware.  There's nothing inherently unique about
> those command codes versus one that ends in an eight [1], or any other
> otherwise valid command codes that are undefined for the device type
> in question.
> 
> [1] POPS states that a x08 is a TIC CCW, and that having any high-order
> bits enabled is invalid for format-1 CCWs.  For format-0 CCWs, the
> high-order bits are ignored.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 36d76b821209..c0a52025bf06 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -289,8 +289,6 @@ static long copy_ccw_from_iova(struct channel_program *cp,
>   #define ccw_is_read_backward(_ccw) (((_ccw)->cmd_code & 0x0F) == 0x0C)
>   #define ccw_is_sense(_ccw) (((_ccw)->cmd_code & 0x0F) == CCW_CMD_BASIC_SENSE)
>   
> -#define ccw_is_test(_ccw) (((_ccw)->cmd_code & 0x0F) == 0)
> -
>   #define ccw_is_noop(_ccw) ((_ccw)->cmd_code == CCW_CMD_NOOP)
>   
>   #define ccw_is_tic(_ccw) ((_ccw)->cmd_code == CCW_CMD_TIC)
> @@ -314,6 +312,10 @@ static inline int ccw_does_data_transfer(struct ccw1 *ccw)
>   	if (ccw->count == 0)
>   		return 0;
>   
> +	/* If the command is a NOP, then no data will be transferred */
> +	if (ccw_is_noop(ccw))
> +		return 0;
> +
>   	/* If the skip flag is off, then data will be transferred */
>   	if (!ccw_is_skip(ccw))
>   		return 1;
> @@ -398,7 +400,7 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
>   {
>   	struct ccw1 *ccw = chain->ch_ccw + idx;
>   
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
> +	if (ccw_is_tic(ccw))


AFAIR, we introduced this code to protect against noop and test with a 
non zero CDA.
This could go away only if there is somewhere the guaranty that noop 
have always a null CDA (same for test).



>   		return;
>   
>   	kfree((void *)(u64)ccw->cda);
> @@ -723,9 +725,6 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>   {
>   	struct ccw1 *ccw = chain->ch_ccw + idx;
>   
> -	if (ccw_is_test(ccw) || ccw_is_noop(ccw))
> -		return 0;
> -
>   	if (ccw_is_tic(ccw))
>   		return ccwchain_fetch_tic(chain, idx, cp);
>   
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
