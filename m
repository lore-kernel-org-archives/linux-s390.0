Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 19 Sep 2019 12:34:34 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 04/10] s390: vfio-ap: filter CRYCB bits for
 unavailable queue devices
In-Reply-To: <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
References: <1568410018-10833-1-git-send-email-akrowiak@linux.ibm.com>
        <1568410018-10833-5-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190919123434.28a29c00.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com

On Fri, 13 Sep 2019 17:26:52 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +static void vfio_ap_mdev_get_crycb_matrix(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	unsigned long apid, apqi;
> +	unsigned long masksz = BITS_TO_LONGS(AP_DEVICES) *
> +			       sizeof(unsigned long);
> +
> +	memset(matrix_mdev->crycb.apm, 0, masksz);
> +	memset(matrix_mdev->crycb.apm, 0, masksz);
> +	memcpy(matrix_mdev->crycb.adm, matrix_mdev->matrix.adm, masksz);
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> +			     matrix_mdev->matrix.apm_max + 1) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> +				     matrix_mdev->matrix.aqm_max + 1) {
> +			if (vfio_ap_find_queue(AP_MKQID(apid, apqi))) {
> +				if (!test_bit_inv(apid, matrix_mdev->crycb.apm))
> +					set_bit_inv(apid,
> +						    matrix_mdev->crycb.apm);
> +				if (!test_bit_inv(apqi, matrix_mdev->crycb.aqm))
> +					set_bit_inv(apqi,
> +						    matrix_mdev->crycb.aqm);
> +			}
> +		}
> +	}
> +}

Even with the discussed typo fixed (zero crycb.aqm) this procedure does
not make sense to me. :(

If in doubt please consider the following example:
matrix_mdev->matrix.apm and matrix_mdev->matrix.aqm have both just bits
0 and 1 set (i.e. first byte 0xC0 the rest of the bytes 0x0). Queues
bound to the vfio_ap driver (0,0), (0,1), (1,0); not bound to vfio_ap is
however (1,1). If I read this correctly this filtering logic would grant
access to (1,1) which seems to contradict with the stated intention.

Regards,
Halil
