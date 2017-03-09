Return-Path: <owner-linux-mm@kvack.org>
MIME-Version: 1.0
In-Reply-To: <20170309130616.51286-3-heiko.carstens@de.ibm.com>
References: <20170309130616.51286-1-heiko.carstens@de.ibm.com> <20170309130616.51286-3-heiko.carstens@de.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Mar 2017 11:11:49 -0800
Message-ID: <CAPcyv4homGf0HVTCYrmYiQobzvp3vSx2zznmgQCabeWmOm6aXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers core: remove assert_held_device_hotplug()
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vladimir Davydov <vdavydov.dev@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 9, 2017 at 5:06 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> The last caller of assert_held_device_hotplug() is gone, so remove it again.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
