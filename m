From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0904/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 16:05:00 +0200
Message-ID: <f900f5ee-35de-6e81-0814-d28e83df1d17@de.ibm.com>
References: <20160802115646.10237-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160802115646.10237-1-baolex.ni@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Baole Ni <baolex.ni@intel.com>, cornelia.huck@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, chuansheng.liu@intel.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

In general, I find sending 1285 patches to lkml unfriendly without doing a
precheck if the general idea is good.
This is especially true as you did NOT provide a cover letter that would
allow to hide this thread on lkml.


Regarding this particular patch, I do not really like this change, as I find
"0444" much easier to parse than "S_IRUSR | S_IRGRP | S_IROTH"

Christian

On 08/02/2016 01:56 PM, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 8688ad4..56d3671 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1074,7 +1074,7 @@ static unsigned long devs_no_auto[__MAX_SSID + 1][__DEV_WORDS];
> 
>  static char *no_auto = "";
> 
> -module_param(no_auto, charp, 0444);
> +module_param(no_auto, charp, S_IRUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(no_auto, "list of ccw bus id ranges not to be auto-onlined");
> 
>  static int virtio_ccw_check_autoonline(struct ccw_device *cdev)
> 
