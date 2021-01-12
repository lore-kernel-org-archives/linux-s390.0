Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbhALQ7m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 11:59:42 -0500
Date: Tue, 12 Jan 2021 17:58:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 12/15] s390/zcrypt: Notify driver on config changed
 and scan complete callbacks
Message-ID: <20210112175850.589d9e4d.pasic@linux.ibm.com>
In-Reply-To: <20201223011606.5265-13-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-13-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 22 Dec 2020 20:16:03 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch intruduces an extension to the ap bus to notify device drivers
> when the host AP configuration changes - i.e., adapters, domains or
> control domains are added or removed. To that end, two new callbacks are
> introduced for AP device drivers:
> 
>   void (*on_config_changed)(struct ap_config_info *new_config_info,
>                             struct ap_config_info *old_config_info);
> 
>      This callback is invoked at the start of the AP bus scan
>      function when it determines that the host AP configuration information
>      has changed since the previous scan. This is done by storing
>      an old and current QCI info struct and comparing them. If there is any
>      difference, the callback is invoked.
> 
>      Note that when the AP bus scan detects that AP adapters, domains or
>      control domains have been removed from the host's AP configuration, it
>      will remove the associated devices from the AP bus subsystem's device
>      model. This callback gives the device driver a chance to respond to
>      the removal of the AP devices from the host configuration prior to
>      calling the device driver's remove callback. The primary purpose of
>      this callback is to allow the vfio_ap driver to do a bulk unplug of
>      all affected adapters, domains and control domains from affected
>      guests rather than unplugging them one at a time when the remove
>      callback is invoked.
> 
>   void (*on_scan_complete)(struct ap_config_info *new_config_info,
>                            struct ap_config_info *old_config_info);
> 
>      The on_scan_complete callback is invoked after the ap bus scan is
>      complete if the host AP configuration data has changed.
> 
>      Note that when the AP bus scan detects that adapters, domains or
>      control domains have been added to the host's configuration, it will
>      create new devices in the AP bus subsystem's device model. The primary
>      purpose of this callback is to allow the vfio_ap driver to do a bulk
>      plug of all affected adapters, domains and control domains into
>      affected guests rather than plugging them one at a time when the
>      probe callback is invoked.
> 
> Please note that changes to the apmask and aqmask do not trigger
> these two callbacks since the bus scan function is not invoked by changes
> to those masks.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
