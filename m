Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 23 May 2019 08:44:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/3] s390: vfio-ccw fixes
Message-ID: <20190523084404.5bc47111.cohuck@redhat.com>
In-Reply-To: <20190516161403.79053-1-farman@linux.ibm.com>
References: <20190516161403.79053-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 16 May 2019 18:14:00 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Here are the remaining patches in my fixes series, to handle the more
> involved scenario of channel programs that do not move any actual data
> to/from the device.  They were reordered per feedback from v2, which
> means they received minor massaging because of overlapping code and
> some cleanup to the commit messages.
> 
> They are based on Conny's vfio-ccw tree.  :)
> 
> Changelog:
>  v2 -> v3:
>   - Patches 1-4:
>      - [Farhan] Added r-b
>      - [Cornelia] Queued to vfio-ccw, dropped from this version
>   - Patches 5/6:
>      - [Cornelia/Farhan] Swapped the order of these patches, minor
>        rework on the placement of bytes/idaw_nr variables and the
>        commit messages that resulted.
>  v2: https://patchwork.kernel.org/cover/10944075/
>  v1: https://patchwork.kernel.org/cover/10928799/
> 
> Eric Farman (3):
>   s390/cio: Don't pin vfio pages for empty transfers
>   s390/cio: Allow zero-length CCWs in vfio-ccw
>   s390/cio: Remove vfio-ccw checks of command codes
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 92 ++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 27 deletions(-)
> 

Thanks, applied.
