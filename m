Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 18:28:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
Message-ID: <20171108182802.036e069a.cohuck@redhat.com>
In-Reply-To: <20171108185948-mutt-send-email-mst@kernel.org>
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
        <20171108185948-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Nov 2017 19:01:07 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Nov 08, 2017 at 06:59:21PM +0200, Michael S. Tsirkin wrote:
> > Virtio UAPI headers aren't just for UAPI, it's for guests/hypervisors as
> > well.  The s390 ones need to be BSD as well.
> > 
> > Fixes: e2be04c7f995 ("License cleanup: add SPDX license identifier to uapi header files with a license")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>  
> 
> A word of warning - this is completely untested. I lost my s390
> cross-build setup. Tested-by would be nice, otherwise
> I will cross-build in the next couple of days and report here.

FWIW, it survives my cross build.
