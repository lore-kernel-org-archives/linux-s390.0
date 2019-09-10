Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Sep 2019 20:10:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: kvm_s390_vm_start_migration: check
 dirty_bitmap before using it as target for memset()
References: <20190910130215.23647-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910130215.23647-1-imammedo@redhat.com>
Message-Id: <20190910181043.GB4313@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org

On Tue, Sep 10, 2019 at 09:02:15AM -0400, Igor Mammedov wrote:
> Make sure that ms->dirty_bitmap is set before using it or
> print a warning and return -ENIVAL otherwise.
...
> v2:
>    - drop WARN()
...
> +		if (!ms->dirty_bitmap)
> +			return -EINVAL;

The patch description needs an update. ;)
