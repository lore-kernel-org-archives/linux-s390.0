From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 17 Aug 2018 08:57:07 +0000
Subject: Re: some comments for "s390/zcrypt: AP bus support for alternate driver(s)"
Message-Id: <20180817105707.6b4a6653.cohuck@redhat.com>
In-Reply-To: <ebb6b4ca-157e-dff3-eab8-6ee96db17cbf@linux.ibm.com>
References: <ebb6b4ca-157e-dff3-eab8-6ee96db17cbf@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Aug 2018 10:39:47 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> I've sent a patch to Heiko/Martin for upstream integration which fixes some of the issues you mentioned:
> And I am working on a patch which makes it possible to give ranges for the bitmap manipulations.

Sounds good!

> regards
> Harald Freudenberger
> 
> >>====================<<  
> 
> From: Harald Freudenberger <freude@linux.ibm.com>
> Date: Fri, 17 Aug 2018 09:01:09 +0200
> Subject: [PATCH] s390/zcrypt: Fix returncode type, typo and block comment
> 
> Minor cleanup patch which fixes 3 complains from upstream review:
> - function ap_instructions_available() had returntype int but
> � in fact returned 1 for true and 0 for false. Changed returntype
> � to bool.
> - Typo in static function name __ap_revice_reserved.
> � revice -> revise for name and the code which called it.
> - Extension on a block comment regarding how devices and drivers
> � with respect of the default flag are handled.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
> �arch/s390/include/asm/ap.h�� |� 6 +++---
> �drivers/s390/crypto/ap_bus.c | 11 ++++++-----
> �2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index 887494aa164f..8c00fd509c45 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -49,9 +49,9 @@ struct ap_queue_status {
> �/**
> � * ap_intructions_available() - Test if AP instructions are available.
> � *
> - * Returns 1 if the AP instructions are installed, otherwise 0.
> + * Returns true if the AP instructions are installed, otherwise false.
> � */
> -static inline int ap_instructions_available(void)
> +static inline bool ap_instructions_available(void)
> �{
> ���� register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
> ���� register unsigned long reg1 asm ("1") = 0;
> @@ -65,7 +65,7 @@ static inline int ap_instructions_available(void)
> ���� ��� : "+d" (reg1), "+d" (reg2)
> ���� ��� : "d" (reg0)
> ���� ��� : "cc");
> -��� return reg1;
> +��� return reg1 != 0;

That applies to the current features branch, right?

> �}
> �
> �/**
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index b1b73945d746..b739a97f6064 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -682,7 +682,7 @@ static struct bus_type ap_bus_type = {
> ���� .pm = &ap_bus_pm_ops,
> �};
> �
> -static int __ap_revice_reserved(struct device *dev, void *dummy)
> +static int __ap_revise_reserved(struct device *dev, void *dummy)
> �{
> ���� int rc, card, queue, devres, drvres;
> �
> @@ -707,7 +707,7 @@ static int __ap_revice_reserved(struct device *dev, void *dummy)
> �
> �static void ap_bus_revise_bindings(void)
> �{
> -��� bus_for_each_dev(&ap_bus_type, NULL, NULL, __ap_revice_reserved);
> +��� bus_for_each_dev(&ap_bus_type, NULL, NULL, __ap_revise_reserved);
> �}
> �
> �int ap_owned_by_def_drv(int card, int queue)
> @@ -758,9 +758,10 @@ static int ap_device_probe(struct device *dev)
> �
> ���� if (is_queue_dev(dev)) {
> ���� ��� /*
> -��� ��� �* For apqns marked as reserved/used by ap bus and
> -��� ��� �* default drivers only drivers with a default flag
> -��� ��� �* will be called for probe this device.
> +��� ��� �* If the apqn is marked as reserved/used by ap bus and
> +��� ��� �* default drivers, only probe with drivers with the default
> +��� ��� �* flag set. If it is not marked, only probe with drivers
> +��� ��� �* with the default flag not set.
> ���� ��� �*/
> ���� ��� card = AP_QID_CARD(to_ap_queue(dev)->qid);
> ���� ��� queue = AP_QID_QUEUE(to_ap_queue(dev)->qid);

These hunks don't, however; you probably want to merge them into your
patch :)

Nevertheless, the changes look good to me.
