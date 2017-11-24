Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 19:02:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] s390/virtio: add BSD license to virtio-ccw
Message-ID: <20171124190132-mutt-send-email-mst@kernel.org>
References: <1511500846-24696-1-git-send-email-mst@redhat.com>
 <1511500846-24696-2-git-send-email-mst@redhat.com>
 <20171124140918.GF4284@osiris>
 <20171124181148-mutt-send-email-mst@kernel.org>
 <20171124165301.GH4284@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124165301.GH4284@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 24, 2017 at 05:53:01PM +0100, Heiko Carstens wrote:
> > > Is there any reason to add the whole BSD 3 clause license text? I'd prefer
> > > if it would be just the simple new SPDX-License-Identifier above.

I added  it for consistency with other virtio headers.
-- 
MST
